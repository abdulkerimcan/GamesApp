//
//  Endpoint.swift
//  GamesAPI
//
//  Created by Abdulkerim Can on 23.02.2025.
//

import Foundation

public enum Endpoint {
    case games(offset: Int, genreId: Int? = nil)
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
        var query = ""
        
        switch self {
        case .games(let offset, let genreId):
            query =  """
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
            limit 10;
            offset \(offset);
            """
            
            if let genreId {
                query += " where genres = (\(genreId));"
            }
        case .genres:
            query = """
            fields 
            name,
            url;
            limit 5;
            """
        case .gameDetail(let id):
            query = """
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
            """
        }
        return query.data(using: .utf8)
    }
}
