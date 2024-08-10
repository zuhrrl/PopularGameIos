//
//  FavoriteGameRouter.swift
//  PopularGames
//
//  Created by WDT on 10/08/24.
//

import Foundation
import SwiftUI

class FavoriteGameRouter {
  func gameDetailView(homePresenter: HomePresenter, gameEntity: GameEntity) -> some View {
    let usecase = Injection.init().provideGameDetail(homePresenter: homePresenter, gameEntity: gameEntity)
    let presenter = GameDetailPresenter(gameDetailUsecase: usecase)
    return GameDetailView(presenter: presenter)
  }
  
}
