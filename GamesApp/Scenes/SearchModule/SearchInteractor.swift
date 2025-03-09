//
//  SearchInteractor.swift
//  GamesApp
//
//  Created by Abdulkerim Can on 9.03.2025.
//

import Foundation
import GamesAPI

final class SearchInteractor: SearchInteractorProtocol {
    weak var delegate: SearchPresenterDelegate?
    private let service: GameServiceProtocol
    
    init(service: GameServiceProtocol) {
        self.service = service
    }
    
    func search(query: String) {
        delegate?.handleOutput(.setLoading(true))
        service.fetchGames(endPoint: .search(searchQuery: query)) { [weak self] result in
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
    
    func loadImage(urlString: String, indexPath: IndexPath) {
        service.loadImage(urlString: urlString) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let image):
                self.delegate?.handleOutput(.setImage(image: image, indexPath: indexPath))
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
