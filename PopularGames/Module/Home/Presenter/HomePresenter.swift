//
//  HomePresenter.swift
//  PopularGames
//
//  Created by WDT on 07/08/24.
//

import Foundation
import Combine
import SwiftUI

class HomePresenter: ObservableObject {
  
  private let router = HomeRouter()
  private var cancellables: Set<AnyCancellable> = []
  private let homeUseCase: HomeUseCase
  
  @Published var listGame: [GameEntity] = []
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false
  @Published var selectedMenu: String = ""
  @Published var selectedGame: Int? = nil
  
  init(homeUseCase: HomeUseCase) {
    self.homeUseCase = homeUseCase
  }
  
  func fetchPopularGames() {
    loadingState = true
    homeUseCase.fetchPopularGames()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
        case .finished:
          self.loadingState = false
        }
      }, receiveValue: { items in
        self.listGame = items
      })
      .store(in: &cancellables)
  }
  
  func gameDetailView(gameEntity: GameEntity) -> some View {
    return router.gameDetailView(homePresenter: self, gameEntity: gameEntity)
  }
  
  func favoriteGameView() -> some View {
    return router.favoriteGameView(homePresenter: self)
  }
  
  func addToFavorite(item: GameEntity) {
    let index = self.listGame.firstIndex(where: {$0.id == item.id})
    debugPrint("FOUND GAME INDEX: \(String(describing: index))")
    if listGame[index!].isFavorite {
      debugPrint("TRYING TO DELETE GAME: \(item.id)")
      listGame[index!].isFavorite = false
      homeUseCase.deleteFavorite(item: item)
      return
    }
    listGame[index!].isFavorite = true
    let updatedItem = GameEntity(id: item.id, title: item.title, genres: item.genres, rating: item.rating, description: item.description, backgroundImage: item.backgroundImage, releasedDate: item.releasedDate, isFavorite: true)
    debugPrint("HomePresenter: usecase add to favorite: \(updatedItem)")
    homeUseCase.addToFavorite(item: updatedItem)
    
  }
  
  func setFavoriteStatus(item: GameEntity, status: Bool) {
    let index = self.listGame.firstIndex(where: {$0.id == item.id})
    self.listGame[index!].isFavorite = status
  }
  
  
}
