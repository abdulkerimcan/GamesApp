//
//  GameDetailViewController.swift
//  GamesApp
//
//  Created by Abdulkerim Can on 5.03.2025.
//

import UIKit

final class GameDetailViewController: UIViewController {

    var presenter: GameDetailPresenterProtocol!
    
    enum Section: CaseIterable {
        case mainImage
        case info
        case images
    }
    
    private var game: Game?
    private let sections: [Section] = Section.allCases
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.load()
        configureVC()
        configureCollectionView()
    }
    
    private func configureVC() {
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(GameDetailImageCollectionViewCell.self, forCellWithReuseIdentifier: GameDetailImageCollectionViewCell.identifier)
        collectionView.register(GameDetailInformationCollectionViewCell.self, forCellWithReuseIdentifier: GameDetailInformationCollectionViewCell.identifier)
    }
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
         return UICollectionViewCompositionalLayout { [weak self] sectionIndex, environment in
             guard let sectionType = self?.sections[sectionIndex] else {
                 fatalError("Invalid section index")
             }
             
             switch sectionType {
             case .mainImage:
                 return self?.createMainImageSection()
             case .info:
                 return self?.createInformationSection()
             case .images:
                 return self?.createScreenshotsSection()
             }
         }
     }
     
     private func createMainImageSection() -> NSCollectionLayoutSection {
         let itemSize = NSCollectionLayoutSize(
             widthDimension: .fractionalWidth(1.0),
             heightDimension: .fractionalHeight(1.0)
         )
         let item = NSCollectionLayoutItem(layoutSize: itemSize)
         
         let groupSize = NSCollectionLayoutSize(
             widthDimension: .fractionalWidth(1.0),
             heightDimension: .fractionalHeight(0.2)
         )
         let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
         
         let section = NSCollectionLayoutSection(group: group)
         section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16)
         
         return section
     }
     
     private func createInformationSection() -> NSCollectionLayoutSection {
         let itemSize = NSCollectionLayoutSize(
             widthDimension: .fractionalWidth(1.0),
             heightDimension: .fractionalHeight(1.0)
         )
         let item = NSCollectionLayoutItem(layoutSize: itemSize)
         
         let groupSize = NSCollectionLayoutSize(
             widthDimension: .fractionalWidth(1.0),
             heightDimension: .fractionalHeight(0.5)
         )
         let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
         
         let section = NSCollectionLayoutSection(group: group)
         section.contentInsets = NSDirectionalEdgeInsets(top: .zero, leading: .zero, bottom: 16, trailing: .zero)
         
         return section
     }
     
     private func createScreenshotsSection() -> NSCollectionLayoutSection {
         let itemSize = NSCollectionLayoutSize(
             widthDimension: .absolute(200),
             heightDimension: .fractionalHeight(1.0)
         )
         let item = NSCollectionLayoutItem(layoutSize: itemSize)
         item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
         
         let groupSize = NSCollectionLayoutSize(
             widthDimension: .estimated(220),
             heightDimension: .fractionalHeight(0.3)
         )
         let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
         
         let section = NSCollectionLayoutSection(group: group)
         section.orthogonalScrollingBehavior = .groupPagingCentered
         section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16)
         
         return section
     }
 }

extension GameDetailViewController: GameDetailViewProtocol {
    func setImage(image: UIImage, indexPath: IndexPath) {
        let sectionType = sections[indexPath.section]
        switch sectionType {
        case .mainImage, .images:
            guard let cell = collectionView.cellForItem(at: indexPath) as? GameDetailImageCollectionViewCell else { return }
            let artwork = sectionType == .images ? game?.screenshots?[indexPath.item] : game?.cover
            cell.setImage(image, with: artwork)
        default:
            break
        }
    }
    
    func update(_ game: Game) {
        self.game = game
        collectionView.reloadData()
    }
}

extension GameDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = sections[section]
        
        switch sectionType {
        case .mainImage, .info:
            return 1
        case .images:
            return game?.screenshots?.count ?? .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = sections[indexPath.section]
        
        switch sectionType {
        case .mainImage, .images:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameDetailImageCollectionViewCell.identifier, for: indexPath) as? GameDetailImageCollectionViewCell else {
                fatalError()
            }
            let urlString = sectionType == .images ? game?.screenshots?[indexPath.item].url ?? "" : game?.cover?.url ?? ""
            
            presenter?.loadImage(urlString: urlString, indexPath: indexPath)
            return cell
        case .info:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameDetailInformationCollectionViewCell.identifier, for: indexPath) as? GameDetailInformationCollectionViewCell else {
                fatalError()
            }
            
            cell.configure(with: game)
            return cell
        }
    }
}
