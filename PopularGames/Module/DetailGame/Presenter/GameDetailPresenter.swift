//
//  GameDetailPresenter.swift
//  PopularGames
//
//  Created by WDT on 09/08/24.
//

import Foundation
import Combine

class  GameDetailPresenter : ObservableObject {
  private let usecase: GameDetailUsecase
  @Published var gameEntity: GameEntity

  init(gameDetailUsecase: GameDetailUsecase) {
    self.usecase = gameDetailUsecase
    gameEntity = gameDetailUsecase.getDetailGame()
  }
  
  func addToFavorite(item: GameEntity) {
    let index = usecase.getHomePresenter().listGame.firstIndex(where: {$0.id == gameEntity.id})
    if usecase.getHomePresenter().listGame[index!].isFavorite {
      usecase.getHomePresenter().listGame[index!].isFavorite = false
      gameEntity.isFavorite = false
      usecase.deleteFavorite(item: item)
      return
    }
    usecase.getHomePresenter().listGame[index!].isFavorite = true
    gameEntity.isFavorite = true
    usecase.addToFavorite(item: item)
  }
  
}
