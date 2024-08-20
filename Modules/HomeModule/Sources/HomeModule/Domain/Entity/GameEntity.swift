//
//  File.swift
//  
//
//  Created by WDT on 15/08/24.
//

import Foundation
public struct GameEntity : Equatable, Identifiable {
  public let id: Int
  public let title: String
  public let genres: String
  public let rating: Double
  public let description: String
  public let backgroundImage: String
  public let releasedDate: String
  public var isFavorite: Bool
}
