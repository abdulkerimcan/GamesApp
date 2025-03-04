//
//  HomeContracts.swift
//  GamesApp
//
//  Created by Abdulkerim Can on 22.02.2025.
//

import UIKit

//View

protocol HomeViewProtocol: AnyObject {
    func handleOutput(_ MovieOutput: HomePresenterProtocolOutput)
}

//Interactor

protocol HomeInteractorProtocol: AnyObject {
    var delegate: HomeInteractorDelegate? { get set }
    func downloadInitialGames()
    func downloadMoreGames(offset: Int, genreId: Int?)
    func downloadGenres()
    func loadImage(urlString: String, indexPath: IndexPath)
    func downloadGames(in genre: Genre)
}

protocol HomeInteractorDelegate: AnyObject {
    func handleOutput(_ output: HomeInteractorDelegateOutput)
}

enum HomeInteractorDelegateOutput {
    case setLoading(Bool)
    case loadingMore(Bool)
    case showGames([Game])
    case showGenres([Genre])
    case setImage(image: UIImage, indexPath: IndexPath)
}

//Presenter

protocol HomePresenterProtocol: AnyObject {
    func load()
    func loadMoreGames()
    func didSelectGame(at index: Int)
    func loadImage(urlString: String?, indexPath: IndexPath)
    func didSelectGenre(at index: Int)
}

enum HomePresenterProtocolOutput {
    case updateTitle(String)
    case setLoading(Bool)
    case showGames([Game])
    case loadingMore(Bool)
    case showGenres([Genre])
    case setImage(image: UIImage, indexPath: IndexPath)
}

//Router

enum HomeRoute {
    case detail(Game)
}

protocol HomeRouterProtocol: AnyObject {
    func navigate(to route: HomeRoute)
}
