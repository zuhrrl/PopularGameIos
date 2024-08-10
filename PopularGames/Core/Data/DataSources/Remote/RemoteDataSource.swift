//
//  RemoteDataSourceProtocol.swift
//  PopularGames
//
//  Created by WDT on 07/08/24.
//

import Foundation
import Combine
import Alamofire

protocol RemoteDataSourceProtocol {
  func fetchPopularGame() -> AnyPublisher<ResponseListGame, Error>
}

final class RemoteDataSource: NSObject {
  private override init() { }
  static let sharedInstance: RemoteDataSource =  RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol {
  func fetchPopularGame() -> AnyPublisher<ResponseListGame, any Error> {
    return Future<ResponseListGame, Error> { completion in
      if let url = URL(string: "\(ApiService.baseUrl)/api/games") {
        AF.request(url)
          .validate()
          .responseDecodable(of: ResponseListGame.self) { response in
            switch response.result {
            case .success(let value):
              completion(.success(value))
            case .failure:
              completion(.failure(URLError.invalidResponse))
            }
          }
      }
    }.eraseToAnyPublisher()
  }
}
