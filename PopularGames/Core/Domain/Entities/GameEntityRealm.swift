//
//  GameEntityRealm.swift
//  PopularGames
//
//  Created by WDT on 10/08/24.
//

import Foundation
import RealmSwift

class GameEntityRealm: Object {
  
  @objc dynamic var id: Int = 0
  @objc dynamic var title: String = ""
  @objc dynamic var genres: String = ""
  @objc dynamic var rating: Double = 0.0
  @objc dynamic var gameDescription: String = ""
  @objc dynamic var backgroundImage: String = ""
  @objc dynamic var releasedDate: String = ""
  @objc dynamic var isFavorite: Int = 0
  
  override static func primaryKey() -> String? {
    return "id"
  }
}
