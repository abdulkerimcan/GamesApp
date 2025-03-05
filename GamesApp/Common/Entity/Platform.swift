//
//  Platform.swift
//  GamesApp
//
//  Created by Abdulkerim Can on 23.02.2025.
//


import Foundation

struct Platform: Hashable {
    let id: Int
    let abbreviation: String?
    let createdAt: Date
    let name: String
    let url: String
    let websites: [Int]?
}
