//
//  RemoteDataSourceImpl.swift
//  PopularGames
//
//  Created by WDT on 07/08/24.
//

import Foundation
import Combine

final class GameRepositoryImpl: NSObject {
  typealias GameRepositoryInstance = (RemoteDataSource, LocaleDataSource) -> GameRepositoryImpl
  fileprivate let remote: RemoteDataSource
  fileprivate let local: LocaleDataSource
  
  private init(remote: RemoteDataSource, local: LocaleDataSource) {
    self.remote = remote
    self.local = local
  }
  
  static let sharedInstance: GameRepositoryInstance = {remoteRepo, localRepo in
    return GameRepositoryImpl(remote: remoteRepo, local: localRepo)
  }
}

extension GameRepositoryImpl: GameRepositoryProtocol {
  func findFavoriteGame(from item: GameEntity) -> AnyPublisher<Bool, any Error> {
    return self.local.findFavoriteGame(from: GameMapper.mapGameEntityToRealm(input: item))
      .map { $0 }
      .eraseToAnyPublisher()
  }
  
  func deleteFavoriteGame(from item: GameEntity) -> AnyPublisher<Bool, any Error> {
    let data = GameMapper.mapGameEntityToRealm(input: item)
    return self.local.deleteFavoriteGame(from: data)
  }
  
  func addToFavorite(item: GameEntity) -> AnyPublisher<Bool, any Error> {
    debugPrint("ADD FAVORITE: \(item)")
    let data = GameMapper.mapGameEntityToRealm(input: item)
    return self.local.addFavoriteGame(from: data)
  }
  
  func fetchFavoriteGame() -> AnyPublisher<[GameEntity], any Error> {
    return self.local.fetchFavoriteGames()
      .map { $0.map {
        item in {
          GameMapper.mapRealmResultToEntities(input: item)
        }()
      } }
      .eraseToAnyPublisher()
  }
  
  
  func fetchPopularGame() -> AnyPublisher<[GameEntity], any Error> {
    return self.remote.fetchPopularGame()
      .flatMap { [self] response -> AnyPublisher<[GameEntity], any Error> in
        if response.results.isEmpty {
          return Just([])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        }
        
        let gameEntitiesPublishers = response.results.map { item in
          let realmItem = GameEntityRealm()
          realmItem.id = item.id
          return self.local.findFavoriteGame(from: realmItem)
            .map { isFavorite -> GameEntity in
              let genres = item.genres.map { $0.name }.joined(separator: ",")
              return GameEntity(
                id: item.id,
                title: item.name,
                genres: genres,
                rating: item.rating,
                description: item.descriptionRaw,
                backgroundImage: item.backgroundImage,
                releasedDate: item.released,
                isFavorite: isFavorite
              )
            }
            .eraseToAnyPublisher()
        }
        return Publishers.MergeMany(gameEntitiesPublishers)
          .collect()
          .eraseToAnyPublisher()
      }
      .eraseToAnyPublisher()
  }
  
}
