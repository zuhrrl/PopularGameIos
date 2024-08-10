//
//  GameEntity.swift
//  PopularGames
//
//  Created by WDT on 10/08/24.
//

import Foundation

struct GameEntity : Equatable, Identifiable {
    let id: Int
    let title: String
    let genres: String
    let rating: Double
    let description: String
    let backgroundImage: String
    let releasedDate: String
    var isFavorite: Bool
}
