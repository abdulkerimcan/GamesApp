//
//  ArtWorkDTO.swift
//  GamesAPI
//
//  Created by Abdulkerim Can on 23.02.2025.
//

import Foundation

public struct ArtWorkDTO: Decodable {
    public let id: Int
    public let height: Int
    public let url: String
    public let width: Int
}
