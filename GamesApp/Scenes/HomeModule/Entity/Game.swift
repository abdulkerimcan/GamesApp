//
//  Game.swift
//  GamesApp
//
//  Created by Abdulkerim Can on 23.02.2025.
//

import Foundation

struct Game {
    let id: Int
    let name: String
    let summary: String?
    let coverID: Int?
    let screenshotIDs: [Int]
    let genres: [Int]
    let platforms: [Int]
    let createdAt: Date
    
    var coverURL: URL? {
        guard let coverID = coverID else { return nil }
        return URL(string: "https://images.igdb.com/igdb/image/upload/t_cover_big/\(coverID).jpg")
    }
}
