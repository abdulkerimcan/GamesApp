//
//  GameTabbarController.swift
//  GamesApp
//
//  Created by Abdulkerim Can on 9.03.2025.
//

import UIKit

final class GameTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        setTabs()
    }
    
    private func setTabs() {
        
        let navs = [createHomeTab(), createSearchTab()]
        
        setViewControllers(navs, animated: true)
    }
}


private extension UIViewController {
    func createHomeTab() -> UINavigationController {
        let homeVC = HomeBuilder.build()
        let nav = UINavigationController(rootViewController: homeVC)
        nav.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 1)
        nav.navigationBar.prefersLargeTitles = true
        return nav
    }
    func createSearchTab() -> UINavigationController {
        let searchVC = SearchBuilder.build()
        let nav = UINavigationController(rootViewController: searchVC)
        nav.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        nav.navigationBar.prefersLargeTitles = true
        return nav
    }
}
