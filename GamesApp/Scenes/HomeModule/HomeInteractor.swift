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
                let games = mapGameDTOsToEntities(gameDTOs)
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
                let games = mapGameDTOsToEntities(gameDTOs)
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
                let games = mapGameDTOsToEntities(gameDTOs)
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

private extension HomeInteractor {
    func mapGameDTOsToEntities(_ gameDTOs: [GameDTO]) -> [Game] {
        return gameDTOs.map { dto in
            return Game(
                id: dto.id,
                name: dto.name,
                createdAt: Date(timeIntervalSince1970: dto.createdAt),
                artworks: dto.artworks?.map { mapArtWorkDTOToEntity($0) },
                cover: dto.cover.map { mapArtWorkDTOToEntity($0) },
                summary: dto.summary,
                genres: dto.genres?.map { mapGenreDTOToEntity($0) },
                platforms: dto.platforms?.map { mapPlatformDTOToEntity($0) },
                screenshots: dto.screenshots?.map { mapArtWorkDTOToEntity($0) }
            )
        }
    }

    func mapArtWorkDTOToEntity(_ dto: ArtWorkDTO) -> ArtWork {
        return ArtWork(
            id: dto.id,
            height: dto.height,
            url: dto.url,
            width: dto.width
        )
    }

    func mapGenreDTOToEntity(_ dto: GenreDTO) -> Genre {
        return Genre(
            id: dto.id,
            name: dto.name,
            url: dto.url
        )
    }

    func mapPlatformDTOToEntity(_ dto: PlatformDTO) -> Platform {
        return Platform(
            id: dto.id,
            abbreviation: dto.abbreviation,
            createdAt: Date(timeIntervalSince1970: dto.createdAt),
            name: dto.name,
            url: dto.url,
            websites: dto.websites
        )
    }
}
