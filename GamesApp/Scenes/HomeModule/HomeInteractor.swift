//
//  HomeInteractor.swift
//  GamesApp
//
//  Created by Abdulkerim Can on 22.02.2025.
//

import Foundation
import GamesAPI

final class HomeInteractor: HomeInteractorProtocol  {
    weak var delegate: HomeInteractorDelegate?
    private let service: GameServiceProtocol
    
    init( service: GameServiceProtocol) {
        self.service = service
    }
    
    func downloadGenres() {
        delegate?.handleOutput(.setLoading(true))
        service.fetchGenres { [weak self] result in
            guard let self else { return }
            self.delegate?.handleOutput(.setLoading(false))
            switch result {
            case .success(let genreDTOs):
                let genres = genreDTOs.map {
                    Genre(id: $0.id, name: $0.name, url: $0.url)
                }
                self.delegate?.handleOutput(.showGenres(genres))
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func downloadGames(in genre: Genre) {
        delegate?.handleOutput(.setLoading(true))
        service.fetchGames(endPoint: .games(offset: .zero, genreId: genre.id)) { [weak self] result in
            guard let self else { return }
            self.delegate?.handleOutput(.setLoading(false))
            switch result {
            case .success(let gameDTOs):
                let games = gameDTOs.mapGameDTOsToEntities()
                self.delegate?.handleOutput(.showGames(games))
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func downloadInitialGames() {
        delegate?.handleOutput(.setLoading(true))
        service.fetchGames(endPoint: .games(offset: .zero)) { [weak self] result in
            guard let self else { return }
            self.delegate?.handleOutput(.setLoading(false))
            switch result {
            case .success(let gameDTOs):
                let games = gameDTOs.mapGameDTOsToEntities()
                self.delegate?.handleOutput(.showGames(games))
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func downloadMoreGames(offset: Int, genreId: Int?) {
        delegate?.handleOutput(.loadingMore(true))
        service.fetchGames(endPoint: .games(offset: offset, genreId: genreId)) { [weak self] result in
            guard let self else { return }
            self.delegate?.handleOutput(.loadingMore(false))
            switch result {
            case .success(let gameDTOs):
                let games = gameDTOs.mapGameDTOsToEntities()
                self.delegate?.handleOutput(.showGames(games))
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func loadImage(urlString: String, indexPath: IndexPath) {
        service.loadImage(urlString: urlString) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let image):
                self.delegate?.handleOutput(.setImage(image: image, indexPath: indexPath))
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
