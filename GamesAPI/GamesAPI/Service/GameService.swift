//
//  GameService.swift
//  GamesAPI
//
//  Created by Abdulkerim Can on 23.02.2025.
//

import Foundation

public protocol GameServiceProtocol {
    func fetchGames(endPoint: Endpoint, completion: @escaping (Result<[GameDTO], Error>) -> Void)
    func fetchGenres(completion: @escaping (Result<[GenreDTO], Error>) -> Void)
}

public class GameService: GameServiceProtocol {
    
    public init() { }
    
    public func fetchGames(endPoint: Endpoint, completion: @escaping (Result<[GameDTO], Error>) -> Void) {
        NetworkManager.shared.request(endPoint, method: .post) { (result: Result<[GameDTO], Error>) in
            switch result {
            case .success(let games):
                completion(.success(games))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func fetchGenres(completion: @escaping (Result<[GenreDTO], any Error>) -> Void) {
        NetworkManager.shared.request(.genres, method: .post) { (result: Result<[GenreDTO], Error>) in
            switch result {
            case .success(let genres):
                completion(.success(genres))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
