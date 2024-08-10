//
//  FavoriteGamePresenter.swift
//  PopularGames
//
//  Created by WDT on 09/08/24.
//

import Foundation
import Combine
import SwiftUI

class FavoriteGamePresenter : ObservableObject {
  private let router = FavoriteGameRouter()
  private var cancellables: Set<AnyCancellable> = []
  private let usecase: FavoriteGameUsecase
  
  @Published var favoriteGame: [GameEntity] = []
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false
  @Published var selectedGame: Int? = nil
  
  init(favoriteGameUsecase: FavoriteGameUsecase) {
    self.usecase = favoriteGameUsecase
  }
  
  func fetchFavoriteGame() {
    if favoriteGame.isEmpty {
      loadingState = true
      usecase.fetchFavoriteGame()
        .receive(on: RunLoop.main)
        .sink(receiveCompletion: { completion in
          switch completion {
          case .failure:
            self.errorMessage = String(describing: completion)
          case .finished:
            self.loadingState = false
          }
        }, receiveValue: { items in
          self.favoriteGame = items
        })
        .store(in: &cancellables)
    }
  }
  
  func deleteFavoriteGame(item: GameEntity) {
    let index = favoriteGame.firstIndex(where: {$0.id == item.id})!
    debugPrint("favorite game presenter delete favorite index: \(String(describing: index))")
    self.favoriteGame.remove(at: index)
    usecase.deleteFavorite(item: item)

  }
  
  func gameDetailView(gameEntity: GameEntity) -> some View {
    return router.gameDetailView(homePresenter: usecase.getHomePresenter(), gameEntity: gameEntity)
  }
  
}
