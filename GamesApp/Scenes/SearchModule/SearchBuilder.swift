//
//  SearchBuilder.swift
//  GamesApp
//
//  Created by Abdulkerim Can on 9.03.2025.
//

import UIKit
import GamesAPI

final class SearchBuilder {
    static func build() -> SearchGameViewController {
        let view = SearchGameViewController()
        let interactor = SearchInteractor(service: GameService())
        let router = SearchRouter(view: view)
        let presenter = SearchPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        return view
    }
}
