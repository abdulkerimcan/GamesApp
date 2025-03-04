//
//  HomeRouter.swift
//  GamesApp
//
//  Created by Abdulkerim Can on 22.02.2025.
//

import UIKit

final class HomeRouter: HomeRouterProtocol {
    private unowned let view: UIViewController
    
    init(view: UIViewController) {
        self.view = view
    }
    
    func navigate(to route: HomeRoute) {
        switch route {
        case .detail:
            print("Navigate")
        }
    }
}
