//
//  GameViewModel.swift
//  PopularGames
//
//  Created by WDT on 26/07/24.
//

import Foundation

class GameViewModel: ObservableObject {
    @Published var listGame: [Game] = []
    @Published var game: Game?
    
    func refreshFavorite(db: DBManager) {
        listGame = db.getAllFavoriteGame()
    }
    
    func setGame(game: Game) {
        self.game = game
        notify()
    }


    func updateGame(game: Game, status: Bool) {
        game.isFavorite = status
        notify()
    }
    
    func updateFavorite(item: Game, status: Bool) {
        var index = listGame.firstIndex(where: {$0.id == item.id})
        listGame[index!].isFavorite = status
        notify()
    }
    func deleteFavorite(item: Game) {
        var index = listGame.firstIndex(where: {$0.id == item.id})
        listGame.remove(at: index!)
        notify()
    }
    
    func notify() {
        self.objectWillChange.send()
    }
}
