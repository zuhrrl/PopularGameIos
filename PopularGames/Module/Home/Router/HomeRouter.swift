//
//  HomeRouter.swift
//  PopularGames
//
//  Created by WDT on 08/08/24.
//

import Foundation
import SwiftUI

class HomeRouter {
  func gameDetailView(homePresenter: HomePresenter, gameEntity: GameEntity) -> some View {
    let usecase = Injection.init().provideGameDetail(homePresenter: homePresenter, gameEntity: gameEntity)
    let presenter = GameDetailPresenter(gameDetailUsecase: usecase)
    return GameDetailView(presenter: presenter)
  }
  
  func favoriteGameView(homePresenter: HomePresenter) -> some View {
    let usecase = Injection.init().provideFavoriteGame(homePresenter: homePresenter)
    let presenter = FavoriteGamePresenter(favoriteGameUsecase: usecase)
    return FavoriteGameView(presenter: presenter)
  }
}
