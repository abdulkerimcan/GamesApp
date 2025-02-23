//
//  GameDTO.swift
//  GamesAPI
//
//  Created by Abdulkerim Can on 23.02.2025.
//

import Foundation

public struct GameDTO: Decodable {
    public let id: Int
    public let artworks: [Int]?
    public let cover: Int?
    public let createdAt: Int
    public let genres: [Int]?
    public let involvedCompanies: [Int]?
    public let name: String
    public let platforms: [Int]?
    public let releaseDates: [Int]?
    public let screenshots: [Int]?
    public let similarGames: [Int]?
    public let summary: String?
    public let videos: [Int]?
    public let websites: [Int]?
    public let languageSupports: [Int]?
    public let gameLocalizations: [Int]?
    public let gameType: Int?
    
    public enum CodingKeys: String, CodingKey {
        case id
        case artworks
        case cover
        case createdAt = "created_at"
        case genres
        case involvedCompanies = "involved_companies"
        case name
        case platforms
        case releaseDates = "release_dates"
        case screenshots
        case similarGames = "similar_games"
        case summary
        case videos
        case websites
        case languageSupports = "language_supports"
        case gameLocalizations = "game_localizations"
        case gameType = "game_type"
    }
}
