//
//  GenreDTO.swift
//  GamesAPI
//
//  Created by Abdulkerim Can on 23.02.2025.
//


import Foundation

public struct GenreDTO: Decodable {
   public let id: Int
   public let createdAt: TimeInterval
   public let name: String
   public let url: String

    enum CodingKeys: String, CodingKey {
        case id, name, url
        case createdAt = "created_at"
    }
}