//
//  GameDetailBuilder.swift
//  GamesApp
//
//  Created by Abdulkerim Can on 5.03.2025.
//

import Foundation

final class GameDetailBuilder {
    static func build(with game: Game) -> GameDetailViewController {
        let view = GameDetailViewController()
        let interactor = GameDetailInteractor(service: .init())
        let presenter = GameDetailPresenter(view: view, game: game, interactor: interactor)
        view.presenter = presenter
        
        return view
    }
}
