//
//  ResponseListGame.swift
//  PopularGames
//
//  Created by WDT on 21/07/24.
//

import Foundation
// MARK: - ResponseListGame
struct ResponseListGame: Codable {
    let status: String
    let results: [ItemGame]
}

// MARK: - Result
struct ItemGame: Codable {
    let id: Int
    let slug, name, released: String
    let backgroundImage: String
    let rating: Double
    let saturatedColor, dominantColor: DominantColor
    let genres: [Genre]
    let clip: Clip
    let shortScreenshots: [ShortScreenshot]
    let descriptionRaw: String

    enum CodingKeys: String, CodingKey {
        case id, slug, name, released
        case backgroundImage = "background_image"
        case rating
        case saturatedColor = "saturated_color"
        case dominantColor = "dominant_color"
        case genres, clip
        case shortScreenshots = "short_screenshots"
        case descriptionRaw = "description_raw"
    }
}

// MARK: - Clip
struct Clip: Codable {
    let clip: String
    let preview: String
}

enum DominantColor: String, Codable {
    case the0F0F0F = "0f0f0f"
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name, slug: String
    let gamesCount: Int
    let imageBackground: String

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}

// MARK: - ShortScreenshot
struct ShortScreenshot: Codable {
    let id: Int
    let image: String
}
