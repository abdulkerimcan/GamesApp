//
//  HomeBuilder.swift
//  GamesApp
//
//  Created by Abdulkerim Can on 22.02.2025.
//

import UIKit

final class HomeBuilder {
    static func build() -> UIViewController {
        let view = HomeViewController()
        let router = HomeRouter(view: view)
        let interactor = HomeInteractor()
        let presenter = HomePresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        return view
    }
}
