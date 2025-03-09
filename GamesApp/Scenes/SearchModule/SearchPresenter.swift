//
//  SearchPresenter.swift
//  GamesApp
//
//  Created by Abdulkerim Can on 9.03.2025.
//

import Foundation

final class SearchPresenter: SearchPresenterProtocol {
    private unowned let view: SearchViewProtocol
    private let interactor: SearchInteractorProtocol
    private let router: SearchRouterProtocol
    private var games = [Game]()
    
    init(view: SearchViewProtocol, interactor: SearchInteractorProtocol, router: SearchRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
        interactor.delegate = self
        view.handleOutput(.setTitle("Search Games"))
    }
    
    
    func search(query: String) {
        interactor.search(query: query)
    }
    
    func didSelectItem(at int: Int) {
        let game = games[int]
        router.route(to: .detail(game))
    }
    
    func loadImage(urlString: String?, indexPath: IndexPath) {
        guard let urlString else { return }
        interactor.loadImage(urlString: urlString, indexPath: indexPath)
    }
}

extension SearchPresenter: SearchPresenterDelegate {
    func handleOutput(_ output: SearchPresenterDelegateOutput) {
        switch output {
        case .showGames(let games):
            self.games = games
            view.handleOutput(.showGames(games))
        case .setLoading(let isLoading):
            view.handleOutput(.setLoading(isLoading))
        case .setImage(image: let image, indexPath: let indexPath):
            view.handleOutput(.setImage(image: image, indexPath: indexPath))
        }
    }
}
