//
//  GameDetailPresenter.swift
//  GamesApp
//
//  Created by Abdulkerim Can on 5.03.2025.
//

import UIKit

final class GameDetailPresenter: GameDetailPresenterProtocol {

    unowned let view: GameDetailViewProtocol
    private let game: Game
    private let interactor: GameDetailInteractorProtocol
    
    init(view: GameDetailViewProtocol, game: Game, interactor: GameDetailInteractorProtocol) {
        self.view = view
        self.game = game
        self.interactor = interactor
        interactor.delegate = self
    }
    
    func load() {
        view.update(game)
    }
    
    func loadImage(urlString: String, indexPath: IndexPath) {
        interactor.loadImage(urlString: urlString, indexPath: indexPath)
    }
}

extension GameDetailPresenter: GameDetailPresenterDelegate {
    func setImage(image: UIImage, indexPath: IndexPath) {
        view.setImage(image: image, indexPath: indexPath)
    }
}
