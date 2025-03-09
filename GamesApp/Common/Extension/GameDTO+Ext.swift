//
//  GameDTO+Ext.swift
//  GamesApp
//
//  Created by Abdulkerim Can on 9.03.2025.
//

import Foundation
import struct GamesAPI.GameDTO


extension [GameDTO] {
    func mapGameDTOsToEntities() -> [Game] {
        return self.map { dto in
            return Game(
                id: dto.id,
                name: dto.name,
                createdAt: Date(timeIntervalSince1970: dto.createdAt),
                artworks: dto.artworks?.map { $0.mapArtWorkDTOToEntity() },
                cover: dto.cover.map { $0.mapArtWorkDTOToEntity() },
                summary: dto.summary,
                genres: dto.genres?.map { $0.mapGenreDTOToEntity() },
                platforms: dto.platforms?.map { $0.mapPlatformDTOToEntity() },
                screenshots: dto.screenshots?.map { $0.mapArtWorkDTOToEntity() }
            )
        }
    }
}
