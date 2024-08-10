//
//  GameRepositoryProtocol.swift
//  PopularGames
//
//  Created by WDT on 07/08/24.
//

import Foundation
import Combine

protocol GameRepositoryProtocol {
  func fetchPopularGame() -> AnyPublisher<[GameEntity], Error>
  func fetchFavoriteGame() -> AnyPublisher<[GameEntity], Error>
  func addToFavorite(item: GameEntity) -> AnyPublisher<Bool, Error>
  func findFavoriteGame(from item: GameEntity) -> AnyPublisher<Bool, Error>
  func deleteFavoriteGame(from item: GameEntity) -> AnyPublisher<Bool, Error>
  
}
