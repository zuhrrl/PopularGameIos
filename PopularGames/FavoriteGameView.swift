//
//  FavoriteGameView.swift
//  PopularGames
//
//  Created by WDT on 27/07/24.
//

import SwiftUI

struct FavoriteGameView: View {
    @State private var goToProfile: Bool = false
    @State var selectedGame: Int? = nil
    @StateObject var gameViewModel = GameViewModel()
    var popularGameViewModel: GameViewModel
    private var dbManager: DBManager
    init(popularGameViewModel: GameViewModel, db: DBManager) {
        self.dbManager = db
        self.popularGameViewModel = popularGameViewModel
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Favorite Games")
                .font(.headline)
                .padding(EdgeInsets(top: 0.0, leading: 35.0, bottom: 0, trailing: 0)
                )
                .foregroundColor(Color(uiColor: .text))
                .font(.system(size: 16, weight: .bold))
                .padding(EdgeInsets(top: 15, leading: 0, bottom: 0, trailing: 0))
            
            
            List(gameViewModel.listGame, id: \.id) {  item in
                ItemFavoriteGame(game: item, isFavorite: item.isFavorite ?? false, onTap: {
                    var saved = dbManager.getFavoriteGameById(id: item.id)
                    
                    if (saved!.isFavorite!) {
                        debugPrint("DISNI IS FAVORIT")
                        dbManager.deleteFavoriteGame(game: item)
                        popularGameViewModel.updateFavorite(item: item, status: false)
                        gameViewModel.deleteFavorite(item: item)
                        return
                    }
                    
                })
                .listRowBackground(Color.clear) // Change Row Color
                .listRowSeparator(.hidden)
                .onTapGesture {
                    self.selectedGame = item.id
                }
                .overlay {
                    NavigationLink(destination: GameDetailView(game: item, popularGameViewModel: popularGameViewModel, db: dbManager), tag: item.id, selection: $selectedGame) {
                        EmptyView().frame(height: 0)
                    }.opacity(0)
                }
                
            }.listStyle(.plain) //Change ListStyle
                .scrollContentBackground(.hidden)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color.init(uiColor: .primary)                           .ignoresSafeArea()
        }
        .task {
            await fetchFavoriteGame()
        }
        
    }
    
    func fetchFavoriteGame() async {
        do {
            gameViewModel.listGame = try await dbManager.getAllFavoriteGame()
        } catch {
            fatalError("Error: connection failed.")
        }
    }
}

#Preview {
    ContentView()
}
