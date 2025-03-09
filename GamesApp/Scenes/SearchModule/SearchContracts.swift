//
//  SearchContracts.swift
//  GamesApp
//
//  Created by Abdulkerim Can on 9.03.2025.
//

import UIKit

protocol SearchPresenterProtocol: AnyObject {
    func search(query: String)
    func didSelectItem(at int: Int)
    func loadImage(urlString: String?, indexPath: IndexPath)
}

enum SearchPresenterDelegateOutput {
    case showGames([Game])
    case setLoading(Bool)
    case setImage(image: UIImage, indexPath: IndexPath)
}
protocol SearchPresenterDelegate: AnyObject {
    func handleOutput(_ output: SearchPresenterDelegateOutput)
}

protocol SearchInteractorProtocol: AnyObject {
    var delegate: SearchPresenterDelegate? { get set }
    func loadImage(urlString: String, indexPath: IndexPath)
    func search(query: String)
}

enum SearchViewProtocolOutput {
    case showGames([Game])
    case setLoading(Bool)
    case setTitle(String)
    case setImage(image: UIImage, indexPath: IndexPath)
}

protocol SearchViewProtocol: AnyObject {
    func handleOutput(_ output: SearchViewProtocolOutput)
}

enum SearchRoute {
    case detail(Game)
}

protocol SearchRouterProtocol: AnyObject {
    func route(to route: SearchRoute)
}

