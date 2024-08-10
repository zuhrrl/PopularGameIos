//
//  HomeInteractor.swift
//  PopularGames
//
//  Created by WDT on 07/08/24.
//

import Foundation
import Combine

protocol HomeUseCase {
  func fetchPopularGames() -> AnyPublisher<[GameEntity], Error>
  func addToFavorite(item: GameEntity) -> Void
  func deleteFavorite(item: GameEntity) -> Void
  func findFavorite(item: GameEntity) -> AnyPublisher<Bool, any Error>
  
}

class HomeInteractor: HomeUseCase {
  
  
  private let repository: GameRepositoryProtocol
  required init(repository: GameRepositoryProtocol) {
    self.repository = repository
  }
  
  func fetchPopularGames() -> AnyPublisher<[GameEntity], any Error> {
    return repository.fetchPopularGame()
  }
  
  func addToFavorite(item: GameEntity) {
    repository.addToFavorite(item: item)
  }
  
  func deleteFavorite(item: GameEntity) {
    repository.deleteFavoriteGame(from: item)
  }
  
  func findFavorite(item: GameEntity) -> AnyPublisher<Bool, any Error> {
   return repository.findFavoriteGame(from: item)
  }
  
}
