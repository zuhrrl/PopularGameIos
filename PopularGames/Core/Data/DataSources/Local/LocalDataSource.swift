//
//  LocalDataSource.swift
//  PopularGames
//
//  Created by WDT on 09/08/24.
//

import Foundation
import RealmSwift
import Combine

protocol LocaleDataSourceProtocol: AnyObject {
  
  func fetchFavoriteGames() -> AnyPublisher<[GameEntityRealm], Error>
  func addFavoriteGame(from item: GameEntityRealm) -> AnyPublisher<Bool, Error>
  func findFavoriteGame(from item: GameEntityRealm) -> AnyPublisher<Bool, Error>
  func deleteFavoriteGame(from item: GameEntityRealm) -> AnyPublisher<Bool, Error>
  
}

final class LocaleDataSource: NSObject {
  
  private let realm: Realm?
  
  private init(realm: Realm?) {
    self.realm = realm
  }
  
  static let sharedInstance: (Realm?) -> LocaleDataSource = { realmDatabase in
    return LocaleDataSource(realm: realmDatabase)
  }
  
}

extension LocaleDataSource: LocaleDataSourceProtocol {
  
  func fetchFavoriteGames() -> AnyPublisher<[GameEntityRealm], any Error> {
    return Future<[GameEntityRealm], Error> { completion in
      if let realm = self.realm {
        let favorites: Results<GameEntityRealm> = {
          realm.objects(GameEntityRealm.self)
            .sorted(byKeyPath: "title", ascending: true)
        }()
        completion(.success(favorites.toArray(ofType: GameEntityRealm.self)))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func addFavoriteGame(from item: GameEntityRealm) -> AnyPublisher<Bool, any Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        do {
          try realm.write {
            realm.add(item, update: .all)
            completion(.success(true))
          }
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func findFavoriteGame(from item: GameEntityRealm) -> AnyPublisher<Bool, any Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        do {
          let found = realm.objects(GameEntityRealm.self).where {
            $0.id == item.id
          }.first
          completion(.success(found != nil ? true : false))
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func deleteFavoriteGame(from item: GameEntityRealm) -> AnyPublisher<Bool, any Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        do {
          try realm.write {
            let found = realm.objects(GameEntityRealm.self).where {
              $0.id == item.id
            }.first!
            debugPrint("I FOUND OBJECT: \(found)")
            realm.delete(found)
            completion(.success(true))
          }
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
}

extension Results {
  
  func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0 ..< count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }
  
}
