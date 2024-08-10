//
//  FavoriteGameInteractor.swift
//  PopularGames
//
//  Created by WDT on 10/08/24.
//

import Foundation
import Combine

protocol FavoriteGameUsecase {
  func fetchFavoriteGame() -> AnyPublisher<[GameEntity], Error>
  func addToFavorite(item: GameEntity) -> Void
  func deleteFavorite(item: GameEntity) -> Void
  func findFavorite(item: GameEntity) -> Void
  func getHomePresenter() -> HomePresenter
}

class FavoriteGameInteractor: FavoriteGameUsecase {
  
  
  private let homePresenter: HomePresenter
  private let repository: GameRepositoryProtocol
  required init(repository: GameRepositoryProtocol, homePresenter: HomePresenter) {
    self.repository = repository
    self.homePresenter = homePresenter
  }
  
  func getHomePresenter() -> HomePresenter {
    return self.homePresenter
  }
  
  func fetchFavoriteGame() -> AnyPublisher<[GameEntity], any Error> {
    debugPrint("USECASE fetchFavoriteGame()")
    return repository.fetchFavoriteGame()
  }
  
  func addToFavorite(item: GameEntity) {
    repository.addToFavorite(item: item)
  }
  
  func deleteFavorite(item: GameEntity) {
    let index = homePresenter.listGame.firstIndex(where: {$0.id == item.id})
    debugPrint("UN FAVORITE TO HOME PRESENTER INDEX: \(index)")
    repository.deleteFavoriteGame(from: item)
  }
  
  func findFavorite(item: GameEntity) {
    repository.findFavoriteGame(from: item)
  }
  
}
