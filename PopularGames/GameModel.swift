//
//  GameModel.swift
//  PopularGames
//
//  Created by WDT on 21/07/24.
//

import Foundation

class Game {
    let id: Int
    let title: String
    let genres: String
    let rating: Double
    let description: String
    let imageUrl: String
    let releasedDate: String
    
    init(
        id: Int,
        title: String,
        genres: String,
        rating: Double,
        description: String,
        imageUrl: String,
        releasedDate: String
    ) {
        self.id = id
        self.title = title
        self.genres = genres
        self.rating = rating
        self.description = description
        self.imageUrl = imageUrl
        self.releasedDate = releasedDate
    }
}
