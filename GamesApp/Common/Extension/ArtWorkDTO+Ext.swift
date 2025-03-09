//
//  ArtWorkDTO+Ext.swift
//  GamesApp
//
//  Created by Abdulkerim Can on 9.03.2025.
//

import Foundation
import struct GamesAPI.ArtWorkDTO

extension ArtWorkDTO {
    func mapArtWorkDTOToEntity() -> ArtWork {
        return ArtWork(
            id: id,
            height: height,
            url: url,
            width: width
        )
    }
}
