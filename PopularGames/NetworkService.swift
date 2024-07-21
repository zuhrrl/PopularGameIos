//
//  NetworkService.swift
//  PopularGames
//
//  Created by WDT on 21/07/24.
//

import Foundation
class NetworkService {
    
    func getPopularGames() async throws -> [Game] {
        let components = URLComponents(string: "https://rawg-mirror.vercel.app/api/games")!
        let request = URLRequest(url: components.url!)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error: Can't fetching data.")
        }
        
        let decoder = JSONDecoder()
        let result = try decoder.decode(ResponseListGame.self, from: data)
        debugPrint(result)
        return gameMapper(input: result.results)
    }
}

extension NetworkService {
    fileprivate func gameMapper(
        input listGame: [ItemGame]
    ) -> [Game] {
        return listGame.map { result in
            var genres = ""
            
            for (index, genre) in result.genres.enumerated() {
                if(index == 0) {
                    genres = genre.name
                    continue
                }
                genres.append(",\(genre.name)")
            }
            return Game(
                id: result.id,
                title: result.name,
                genres: genres,
                rating: result.rating,
                description:  result.descriptionRaw,
                imageUrl:  result.backgroundImage,
                releasedDate: result.released
            )
        }
    }
}
