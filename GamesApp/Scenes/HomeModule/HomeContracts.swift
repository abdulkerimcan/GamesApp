//
//  HomeContracts.swift
//  GamesApp
//
//  Created by Abdulkerim Can on 22.02.2025.
//

import Foundation


//View

protocol HomeViewProtocol: AnyObject {
    func handleOutput(_ MovieOutput: HomePresenterProtocolOutput)
}

//Interactor

protocol HomeInteractorProtocol: AnyObject {
    var delegate: HomeInteractorDelegate? { get set }
    func downloadGames()
}

protocol HomeInteractorDelegate: AnyObject {
    func handleOutput(_ output: HomeInteractorDelegateOutput)
}

enum HomeInteractorDelegateOutput {
    case setLoading(Bool)
    case showGames // -> Add games array
}

//Presenter

protocol HomePresenterProtocol: AnyObject {
    func load()
    func selectGame(at index: Int)
}

enum HomePresenterProtocolOutput {
    case updateTitle(String)
    case setLoading(Bool)
    case showGames // -> Add games array
}

//Router

enum HomeRoute {
    case detail // (Game)
}

protocol HomeRouterProtocol: AnyObject {
    func navigate(to route: HomeRoute)
}
