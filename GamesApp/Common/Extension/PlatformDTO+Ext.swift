//
//  PlatformDTO+Ext.swift
//  GamesApp
//
//  Created by Abdulkerim Can on 9.03.2025.
//

import Foundation
import struct GamesAPI.PlatformDTO

extension PlatformDTO {
    func mapPlatformDTOToEntity() -> Platform {
        return Platform(
            id: id,
            abbreviation: abbreviation,
            createdAt: Date(timeIntervalSince1970: createdAt),
            name: name,
            url: url,
            websites: websites
        )
    }
}
