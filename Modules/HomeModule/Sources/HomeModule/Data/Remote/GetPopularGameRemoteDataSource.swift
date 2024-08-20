//
//  File.swift
//
//
//  Created by WDT on 15/08/24.
//

import Foundation
import Combine
import Alamofire
import Core

public struct GetPopularGameRemoteDataSource: DataSource {
  public typealias Request = Any
  public typealias Response = [ItemGame]
  private let endpoint: String
  
  public init(endpoint: String) {
    self.endpoint = endpoint
  }
  
  public func execute(request: Any?) -> AnyPublisher<[ItemGame], Error> {
    return Future<[ItemGame], Error> { completion in
      if let url = URL(string: endpoint) {
        AF.request(url)
          .validate()
          .responseDecodable(of: PopularGameResponse.self) { response in
            switch response.result {
            case .success(let value):
              completion(.success(value.results))
            case .failure:
              completion(.failure(URLError.invalidResponse))
            }
          }
      }
    }.eraseToAnyPublisher()
  }
}
