//
//  Endpoint.swift
//  GamesAPI
//
//  Created by Abdulkerim Can on 23.02.2025.
//

import Foundation

enum Endpoint {
    case games
    case gameDetail(id: Int)
    case genres
    
    private static let baseURL = URL(string: "https://api.igdb.com/v4")!
    
    var url: URL {
        switch self {
        case .games:
            Endpoint.baseURL.appendingPathComponent("games")
        case .gameDetail:
            Endpoint.baseURL.appendingPathComponent("games")
        case .genres:
            Endpoint.baseURL.appendingPathComponent("genres")
        }
    }
    
    var body: Data? {
        switch self {
        case .games:
            """
            fields 
            artworks.*,
            cover.*,
            created_at,
            genres.*,
            name,
            platforms.*,
            rating,
            screenshots.*,
            summary,
            videos.*;
            limit 30;
            """.data(using: .utf8)
        case .genres:
            """
            fields 
            name,
            url;
            """.data(using: .utf8)
        case .gameDetail(let id):
            """
            fields  
            artworks.*,
            cover.*,
            created_at,
            genres.*,
            name,
            platforms.*,
            rating,
            screenshots.*,
            summary,
            videos.*;
            where id = \(id);
            """.data(using: .utf8)
        }
    }
}
