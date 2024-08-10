//
//  Injection.swift
//  PopularGames
//
//  Created by WDT on 07/08/24.
//

import Foundation
import RealmSwift

final class Injection: NSObject {
  private func provideRepository() -> GameRepositoryProtocol {
    let realm = try? Realm()
    
    let remote: RemoteDataSource = RemoteDataSource.sharedInstance
    let local: LocaleDataSource = LocaleDataSource.sharedInstance(realm)
    return GameRepositoryImpl.sharedInstance(remote, local)
  }
  
  func provideHome() -> HomeUseCase {
    let repository = provideRepository()
    return HomeInteractor(repository: repository)
  }
  
  func provideGameDetail(homePresenter: HomePresenter, gameEntity: GameEntity) -> GameDetailUsecase {
    let repository = provideRepository()
    return GameDetailInteractor(repository: repository, homePresenter: homePresenter,gameEntity: gameEntity)
  }
  
  func provideFavoriteGame(homePresenter: HomePresenter) -> FavoriteGameUsecase {
    let repository = provideRepository()
    return FavoriteGameInteractor(repository: repository, homePresenter: homePresenter)
  }
  
}
