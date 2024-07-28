//
//  GameDetailView.swift
//  PopularGames
//
//  Created by WDT on 21/07/24.
//

import SwiftUI

struct GameDetailView: View {
    @State var game: Game
    private var dbManager: DBManager
    var popularGameViewModel: GameViewModel
    @State var isFavorite : Bool
    
    init(game: Game, popularGameViewModel: GameViewModel, db: DBManager) {
        self.dbManager = db
        self.game = game
        self.popularGameViewModel = popularGameViewModel
        self.isFavorite = game.isFavorite!
    }


    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading){
                    AsyncImage(url: URL(string: "\(game.imageUrl)")) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray
                    }
                    .frame(height: 200.0)
                    .clipShape(.rect(cornerRadius: 15))
                    HStack {
                        Text("Created At: \(game.releasedDate)")
                            .foregroundColor(Color(uiColor: .text))

                            .font(.system(size: 20))
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                        Spacer()
                        Image(systemName: isFavorite ? "heart.fill" :  "heart")
                            .resizable()
                            .frame(width: 25.0, height: 25.0)
                            .padding(EdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 20.0)
                            )
                            .foregroundColor(.white)
                            .onTapGesture {
                                var saved = dbManager.getFavoriteGameById(id: game.id)
                                //
                                if saved == nil {
                                    debugPrint("success add to favorite")
                                    dbManager.addToFavorite(game: game)
                                    popularGameViewModel.updateFavorite(item: game, status: true)
                                    isFavorite = true
                                    return;
                                }
                                //
                                
                                if (saved!.isFavorite!) {
                                    dbManager.updateGame(game: game, status: false)
                                    dbManager.deleteFavoriteGame(game: game)
                                    popularGameViewModel.updateFavorite(item: game, status: false)
                                    isFavorite = false
                                    
                                    return
                                }
                                
                                if (saved!.isFavorite == false) {
                                    dbManager.updateGame(game: game, status: true)
                                    popularGameViewModel.updateFavorite(item: game, status: true)
                                    isFavorite = true
                                    return
                                }
                            }
                        
                    }
                    Text("\(game.title)")
                        .foregroundColor(Color(uiColor: .text))

                        .font(.title)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                    
                    Text("\(game.description)")
                        .foregroundColor(Color(uiColor: .text))

                        .font(.system(size: 20))
                    
                    Text("Rating: \(String(format: "%.2f", game.rating))")
                        .foregroundColor(Color(uiColor: .text))

                        .font(.title)
                        .padding(EdgeInsets(top: 15, leading: 0, bottom: 10, trailing: 0))
                    
                }
                .padding(25)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                Color.init(uiColor: .primary)
                    .ignoresSafeArea()
            }
            
            
        }

    }
    
}

#Preview {
    ContentView()
}
