//
//  File.swift
//  
//
//  Created by WDT on 16/08/24.
//

import Foundation
public struct PopularGameResponse: Codable {
    let status: String
    let results: [ItemGame]
}

// MARK: - Result
public struct ItemGame: Codable {
    let id: Int
    let slug, name, released: String
    let backgroundImage: String
    let rating: Double
    let genres: [Genre]
    let clip: Clip
    let shortScreenshots: [ShortScreenshot]
    let descriptionRaw: String

    enum CodingKeys: String, CodingKey {
        case id, slug, name, released
        case backgroundImage = "background_image"
        case rating
        case genres, clip
        case shortScreenshots = "short_screenshots"
        case descriptionRaw = "description_raw"
    }
}

// MARK: - Clip
public struct Clip: Codable {
    let clip: String
    let preview: String
}

// MARK: - Genre
public struct Genre: Codable {
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
public struct ShortScreenshot: Codable {
    let id: Int
    let image: String
}
