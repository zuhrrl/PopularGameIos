//
//  DetailGameInteractor.swift
//  PopularGames
//
//  Created by WDT on 09/08/24.
//

import Foundation

protocol GameDetailUsecase {
  func getDetailGame() -> GameEntity
  func addToFavorite(item: GameEntity) -> Void
  func deleteFavorite(item: GameEntity) -> Void
  func findFavorite(item: GameEntity) -> Void
  func getHomePresenter() -> HomePresenter
}

class GameDetailInteractor : GameDetailUsecase {
 
  
  private let repository: GameRepositoryProtocol
  private let homePresenter: HomePresenter
  private var gameEntity: GameEntity
  
  init(repository: GameRepositoryProtocol, homePresenter: HomePresenter, gameEntity: GameEntity) {
    self.repository = repository
    self.gameEntity = gameEntity
    self.homePresenter = homePresenter
  }
  
  func getHomePresenter() -> HomePresenter {
    return self.homePresenter
  }
  
  func getDetailGame() -> GameEntity {
    return gameEntity
  }
  
  func addToFavorite(item: GameEntity) -> Void {
    repository.addToFavorite(item: item)
  }
  
  func deleteFavorite(item: GameEntity) {
    repository.deleteFavoriteGame(from: item)
  }
  
  func findFavorite(item: GameEntity) {
    repository.findFavoriteGame(from: item)
  }
}
