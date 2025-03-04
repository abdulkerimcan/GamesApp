//
//  HomeBuilder.swift
//  GamesApp
//
//  Created by Abdulkerim Can on 22.02.2025.
//

import UIKit
import GamesAPI

final class HomeBuilder {
    static func build() -> UIViewController {
        let view = HomeViewController()
        let router = HomeRouter(view: view)
        let gameService = GameService()
        let interactor = HomeInteractor(service: gameService)
        let presenter = HomePresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        return view
    }
}
