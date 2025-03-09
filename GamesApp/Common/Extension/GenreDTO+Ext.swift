//
//  GenreDTO+Ext.swift
//  GamesApp
//
//  Created by Abdulkerim Can on 9.03.2025.
//

import Foundation
import struct GamesAPI.GenreDTO

extension GenreDTO {
    func mapGenreDTOToEntity() -> Genre {
        return Genre(
            id: id,
            name: name,
            url: url
        )
    }
}
