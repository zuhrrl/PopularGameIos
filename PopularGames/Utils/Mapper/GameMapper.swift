//
//  GameMapper.swift
//  PopularGames
//
//  Created by WDT on 07/08/24.
//

import Foundation

class GameMapper {
  
  static func mapRealmResultToEntities(
    input item: GameEntityRealm
  ) -> GameEntity {
    
    debugPrint("MAPPING REALM: \(item)")
    return GameEntity(
      id: item.id,
      title: item.title,
      genres: item.genres,
      rating: item.rating,
      description: item.gameDescription,
      backgroundImage: item.backgroundImage,
      releasedDate: item.releasedDate,
      isFavorite: item.isFavorite == 1 ? true : false
    )
  }
  
  static func mapGameEntityToRealm(
    input response: GameEntity
  ) -> GameEntityRealm {
    let game = GameEntityRealm()
    game.id = response.id
    game.title = response.title
    game.genres = response.genres
    game.rating = response.rating
    game.gameDescription = response.description
    game.backgroundImage = response.backgroundImage
    game.releasedDate = response.releasedDate
    game.isFavorite = response.isFavorite ? 1 : 0
    
    return game
  }
  
}
