//
//  SearchRouter.swift
//  GamesApp
//
//  Created by Abdulkerim Can on 9.03.2025.
//

import UIKit


final class SearchRouter: SearchRouterProtocol {
    private unowned let view: UIViewController
    
    init(view: UIViewController) {
        self.view = view
    }
    
    func route(to route: SearchRoute) {
        switch route {
        case .detail(let game):
            let gameDetailViewController = GameDetailBuilder.build(with: game)
            view.navigationController?.pushViewController(gameDetailViewController, animated: true)
        }
    }
}
