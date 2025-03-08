//
//  HomePresenter.swift
//  GamesApp
//
//  Created by Abdulkerim Can on 22.02.2025.
//

import Foundation

final class HomePresenter: HomePresenterProtocol {
    private var selectedGenreId: Int?
    private var currentOffset: Int = 0
    private unowned let view: HomeViewProtocol
    private let interactor: HomeInteractorProtocol
    private let router: HomeRouterProtocol
    private var genres: [Genre] = []
    private var games: [Game] = []
    
    init(view: HomeViewProtocol, interactor: HomeInteractorProtocol, router: HomeRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.interactor.delegate = self
    }
    
    
    func loadImage(urlString: String?, indexPath: IndexPath) {
        guard let urlString = urlString else { return }
        interactor.loadImage(urlString: urlString, indexPath: indexPath)
    }
    
    func didSelectGame(at index: Int) {
        let game = games[index]
        router.navigate(to: .detail(game))
    }
    
    func didSelectGenre(at index: Int) {
        games.removeAll()
        selectedGenreId = genres[index].id
        let genre = genres[index]
        interactor.downloadGames(in: genre)
    }
    
    func loadMoreGames() {
        currentOffset += 10
        interactor.downloadMoreGames(offset: currentOffset, genreId: selectedGenreId)
    }
    
    func load() {
        view.handleOutput(.updateTitle("Games"))
        interactor.downloadInitialGames()
        interactor.downloadGenres()
    }
}

extension HomePresenter: HomeInteractorDelegate {
    func handleOutput(_ output: HomeInteractorDelegateOutput) {
        switch output {
        case .setLoading(let isLoading):
            view.handleOutput(.setLoading(isLoading))
        case .showGames(let games):
            self.games.append(contentsOf: games)
            view.handleOutput(.showGames(games))
        case .setImage(image: let image, indexPath: let indexPath):
            view.handleOutput(.setImage(image: image, indexPath: indexPath))
        case .showGenres(let genres):
            self.genres = genres
            view.handleOutput(.showGenres(genres))
        case .loadingMore(let loadingMore):
            view.handleOutput(.loadingMore(loadingMore))
        }
    }
}
