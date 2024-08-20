//
//  GameTransformer.swift
//
//  Created by WDT on 16/08/24.
//

import Foundation
import Core

public struct GameTransformer: Mapper {
    public typealias Response = [ItemGame]
    public typealias Entity = [GameEntity]
    public typealias Domain = [GameEntity]
    
    // Initializer
    public init() {}
    
    // Convert API response to internal entity
    public func toEntity(response: [ItemGame]) -> [GameEntity] {
      return response.map { item in
        GameEntity(id: item.id, title: item.name, genres: "test", rating: item.rating, description: item.descriptionRaw, backgroundImage: item.backgroundImage, releasedDate: item.released, isFavorite: false)
      }
    }
    
    public func toDomain(entity: [GameEntity]) -> [GameEntity] {
      return entity
    }
}

