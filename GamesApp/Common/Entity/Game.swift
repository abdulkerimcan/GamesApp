//
//  Game.swift
//  GamesApp
//
//  Created by Abdulkerim Can on 23.02.2025.
//

import Foundation

struct Game: Hashable {
    let id: Int
    let name: String
    let createdAt: Date
    let artworks: [ArtWork]?
    let cover: ArtWork?
    let summary: String?
    let genres: [Genre]?
    let platforms: [Platform]?
    let screenshots: [ArtWork]?
}

