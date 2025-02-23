//
//  PlatformDTO.swift
//  GamesAPI
//
//  Created by Abdulkerim Can on 23.02.2025.
//


import Foundation

public struct PlatformDTO: Decodable {
    public let id: Int
    public let abbreviation: String?
    public let createdAt: TimeInterval
    public let name: String
    public let url: String
    public let websites: [Int]?

    enum CodingKeys: String, CodingKey {
        case id, abbreviation, name, url, websites
        case createdAt = "created_at"
    }
}
