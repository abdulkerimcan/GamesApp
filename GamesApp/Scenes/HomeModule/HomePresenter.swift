//
//  HomePresenter.swift
//  GamesApp
//
//  Created by Abdulkerim Can on 22.02.2025.
//

import Foundation

final class HomePresenter: HomePresenterProtocol {
    func load() {
        view.handleOutput(.updateTitle("Kerim's Games"))
        interactor.downloadGames()
    }
    
    func selectGame(at index: Int) {
        
    }
    
    private unowned let view: HomeViewProtocol
    private let interactor: HomeInteractorProtocol
    private let router: HomeRouterProtocol
    
    init(view: HomeViewProtocol, interactor: HomeInteractorProtocol, router: HomeRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.interactor.delegate = self
    }
}

extension HomePresenter: HomeInteractorDelegate {
    func handleOutput(_ output: HomeInteractorDelegateOutput) {
        switch output {
        case .setLoading(let isLoading):
            view.handleOutput(.setLoading(isLoading))
        case .showGames:
            view.handleOutput(.showGames)
        }
    }
}
