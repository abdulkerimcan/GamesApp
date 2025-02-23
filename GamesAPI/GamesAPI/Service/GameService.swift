//
//  GameService.swift
//  GamesAPI
//
//  Created by Abdulkerim Can on 23.02.2025.
//

import Foundation

public protocol GameServiceProtocol {
    func fetchGames(completion: @escaping (Result<[GameDTO], Error>) -> Void)
}

public class GameService: GameServiceProtocol {
    
    public init() { }
    
    public func fetchGames(completion: @escaping (Result<[GameDTO], Error>) -> Void) {
        NetworkManager.shared.request(.games, method: .post) { (result: Result<[GameDTO], Error>) in
            switch result {
            case .success(let games):
                completion(.success(games))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }    
}
