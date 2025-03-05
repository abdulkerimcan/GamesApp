//
//  ViewController.swift
//  GamesApp
//
//  Created by Abdulkerim Can on 22.02.2025.
//

import UIKit

final class HomeViewController: UIViewController, HomeViewProtocol {
    
    // MARK: - Enum & Type Definitions
    private enum SectionType: CaseIterable {
        case genre
        case games
    }
    
    private enum ItemType: Hashable {
        case genre(Genre)
        case game(Game)
    }
    
    // MARK: - Properties
    var presenter: HomePresenterProtocol!
    
    private typealias DataSource = UICollectionViewDiffableDataSource<SectionType, ItemType>
    private var dataSource: DataSource!
    private var isLoadingMoreData: Bool = false
    private var games: [Game] = []
    private var genres: [Genre] = []
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.allowsSelection = true
        return collectionView
    }()
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureCollectionView()
        configureDataSource()
        presenter?.load()
    }
    
    // MARK: - Configuration
    private func configureVC() {
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(collectionView)
        view.addSubview(spinner)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            spinner.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor),
        ])
    }
    
    private func configureCollectionView() {
        collectionView.register(GenreCollectionViewCell.self, forCellWithReuseIdentifier: GenreCollectionViewCell.identifier)
        collectionView.register(GameCollectionViewCell.self, forCellWithReuseIdentifier: GameCollectionViewCell.identifier)
        collectionView.register(HomeCollectionFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: HomeCollectionFooterView.identifier)
        collectionView.delegate = self
    }
    
    private func configureDataSource() {
        dataSource = DataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, itemType in
            switch itemType {
            case .genre(let genre):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionViewCell.identifier, for: indexPath) as? GenreCollectionViewCell else {
                    fatalError()
                }
                cell.configure(with: genre.name)
                return cell
                
            case .game(let game):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCollectionViewCell.identifier, for: indexPath) as? GameCollectionViewCell else {
                    fatalError()
                }
                cell.configure(with: game)
                self?.presenter.loadImage(urlString: game.cover?.url, indexPath: indexPath)
                return cell
            }
        }
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionFooter,
                  let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeCollectionFooterView.identifier, for: indexPath) as? HomeCollectionFooterView else {
                fatalError("Cannot create footer view")
            }
            footer.startLoading()
            return footer
        }
    }
    
    // MARK: - HomeViewProtocol
    func handleOutput(_ output: HomePresenterProtocolOutput) {
        switch output {
        case .updateTitle(let newTitle):
            title = newTitle
            
        case .setLoading(let isLoading):
            isLoading ? startAnimating() : stopAnimating()
            
        case .showGames(let newGames):
            updateGamesSection(with: newGames)
            
        case .showGenres(let genres):
            updateGenresSection(with: genres)
            
        case .setImage(image: let image, indexPath: let indexPath):
            guard let cell = collectionView.cellForItem(at: indexPath) as? GameCollectionViewCell else { return }
            cell.setImage(image)
            
        case .loadingMore(let isLoadingMore):
            self.isLoadingMoreData = isLoadingMore
        }
    }
    
    // MARK: - Private Methods
    private func updateGenresSection(with genres: [Genre]) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.genres = genres
            var snapshot = NSDiffableDataSourceSnapshot<SectionType, ItemType>()
            snapshot.appendSections([.genre])
            let genreItems = genres.map { ItemType.genre($0) }
            snapshot.appendItems(genreItems, toSection: .genre)
            
            dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    private func updateGamesSection(with games: [Game]) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.games.append(contentsOf: games)
            var snapshot = self.dataSource.snapshot()
            
            if !snapshot.sectionIdentifiers.contains(.games) {
                snapshot.appendSections([.games])
            }
            
            let gameItems = games.map { ItemType.game($0) }
            snapshot.appendItems(gameItems, toSection: .games)
            
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    private func startAnimating() {
        DispatchQueue.main.async { [weak self] in
            self?.spinner.startAnimating()
        }
    }
    
    private func stopAnimating() {
        DispatchQueue.main.async { [weak self] in
            self?.spinner.stopAnimating()
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        
        switch item {
        case .genre:
            var snapshot = dataSource.snapshot()
            snapshot.deleteSections([.games])
            games.removeAll()
            presenter?.didSelectGenre(at: indexPath.item)
            dataSource.apply(snapshot, animatingDifferences: true)
        case .game:
            presenter?.didSelectGame(at: indexPath.item)
        }
    }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let totalContentHeight = scrollView.contentSize.height
        let totalScrollViewFixedHeight = scrollView.frame.size.height
        
        if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120),
           !isLoadingMoreData {
            isLoadingMoreData = true
            presenter?.loadMoreGames()
        }
    }
}

private extension HomeViewController {
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, environment in
            let section = SectionType.allCases[sectionIndex]
            switch section {
            case .genre:
                return self.createGenresLayoutSection()
            case .games:
                return self.createGamesLayoutSection()
            }
        }
    }
    
    func createGenresLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .absolute(40))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .absolute(40))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        return section
    }
    
    func createGamesLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(400))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = 8
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100)),
                elementKind: UICollectionView.elementKindSectionFooter,
                alignment: .bottom)
        ]
        
        return section
    }
}
