//
//  File.swift
//
//
//  Created by WDT on 16/08/24.
//

import Foundation
import Core
import Combine

public struct GetPopularGameRepository<
  RemoteDataSource: DataSource,
  Transformer: Mapper>: Repository
where
RemoteDataSource.Response == [ItemGame],
Transformer.Response == [ItemGame],
Transformer.Entity == [GameEntity],
Transformer.Domain == [GameEntity] {
  

  public typealias Request = Any
  public typealias Response = [GameEntity]
  
  private let remoteDataSource: RemoteDataSource
  private let mapper: Transformer
  
  public init(
    remoteDataSource: RemoteDataSource,
    mapper: Transformer) {
      self.remoteDataSource = remoteDataSource
      self.mapper = mapper
    }
  
  public func execute(request: Request?) -> AnyPublisher<[GameEntity], any Error> {
    return remoteDataSource.execute(request: nil)
      .map {mapper.toEntity(response: $0)}
      .eraseToAnyPublisher()
  }
  
  
}
