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
    func downloadGames() {
        delegate?.handleOutput(.setLoading(true))
        service.fetchGames { [weak self] result in
            guard let self else { return }
            self.delegate?.handleOutput(.setLoading(false))
            switch result {
            case .success(let gameDTOs):
                let games = gameDTOs.map { dto in
                    return Game(
                        id: dto.id,
                        name: dto.name,
                        summary: dto.summary,
                        coverID: dto.cover,
                        screenshotIDs: dto.screenshots ?? [],
                        genres: dto.genres ?? [],
                        platforms: dto.platforms ?? [],
                        createdAt: Date(timeIntervalSince1970: TimeInterval(dto.createdAt))
                    )
                }
                self.delegate?.handleOutput(.showGams(games))
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
