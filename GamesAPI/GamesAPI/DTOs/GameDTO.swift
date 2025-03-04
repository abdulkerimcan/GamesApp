//
//  GameDTO.swift
//  GamesAPI
//
//  Created by Abdulkerim Can on 23.02.2025.
//

import Foundation

public struct GameDTO: Decodable {
    public let id: Int
    public let name: String
    public let createdAt: TimeInterval
    public let artworks: [ArtWorkDTO]?
    public let cover: ArtWorkDTO?
    public let summary: String?
    public let genres: [GenreDTO]?
    public let platforms: [PlatformDTO]?
    public let screenshots: [ArtWorkDTO]?

    enum CodingKeys: String, CodingKey {
        case id, name, artworks, cover, genres, platforms, screenshots, summary
        case createdAt = "created_at"
    }
}

