//
//  ContentView.swift
//  PopularGames
//
//  Created by WDT on 21/07/24.
//

import SwiftUI

struct ContentView: View {
    @State private var goToProfile: Bool = false
    @State private var goToFavorite: Bool = false
    @State var selectedGame: Int? = nil
    @StateObject var gameViewModel = GameViewModel()
    private var dbManager: DBManager = DBManager()
    
    var body: some View {
        NavigationView(content: {
            
            VStack(alignment: .leading) {
                Text("Popular Games")
                    .font(.headline)
                    .padding(EdgeInsets(top: 0.0, leading: 35.0, bottom: 0, trailing: 0)
                    )
                    .foregroundColor(Color(uiColor: .text))
                    .font(.system(size: 16, weight: .bold))
                    .padding(EdgeInsets(top: 15, leading: 0, bottom: 0, trailing: 0))
                
                
                List(gameViewModel.listGame, id: \.id) {  item in
                    ItemCardGame(game: item, isFavorite: item.isFavorite ?? false, onTap: {
                        gameViewModel.setGame(game: item)
                        var saved = dbManager.getFavoriteGameById(id: item.id)
                        //
                        if saved == nil {
                            debugPrint("success add to favorite")
                            dbManager.addToFavorite(game: item)
                            gameViewModel.updateFavorite(item: item, status: true)
                            return;
                        }
                        //
                        
                        if (saved!.isFavorite!) {
                            dbManager.updateGame(game: item, status: false)
                            gameViewModel.updateFavorite(item: item, status: false)
                            return
                        }
                        
                        if (saved!.isFavorite == false) {
                            dbManager.updateGame(game: item, status: true)
                            gameViewModel.updateFavorite(item: item, status: true)
                            return
                        }
                        
                        
                    })
                    .listRowBackground(Color.clear) // Change Row Color
                    .listRowSeparator(.hidden)
                    .onTapGesture {
                        self.selectedGame = item.id
                    }
                    .overlay {
                        NavigationLink(destination: GameDetailView(game: item, popularGameViewModel: gameViewModel, db: dbManager), tag: item.id, selection: $selectedGame) {
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
            .navigationBarItems(
                leading: Button {
                    print("Favorite")
                } label: {
                    NavigationLink(destination: FavoriteGameView(popularGameViewModel: gameViewModel, db: dbManager), isActive: self.$goToFavorite) {
                        
                    }
                    HStack {
                        Image(systemName: "bookmark")
                            .foregroundColor(.white)
                            .frame(width: 30, height: 30)
                            .padding(EdgeInsets(top: 0.0, leading: 0, bottom: 0.0, trailing: 0)
                            )
                            .foregroundColor(.black)
                        Text("Favorite")
                            .font(.system(size: 14, weight: .bold))
                            .padding(EdgeInsets(top: 0.0, leading: 0, bottom: 0, trailing: 0)
                            ).truncationMode(/*@START_MENU_TOKEN@*/.tail/*@END_MENU_TOKEN@*/)
                            .lineLimit(1)
                        .foregroundColor(Color(uiColor: .text))                    }
                    .onTapGesture {
                        print("Profile Tap \(self.goToProfile)")
                        self.goToFavorite.toggle()
                    }.padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))
                    
                    
                },
                trailing:  Button {
                    print("Profile")
                } label: {
                    NavigationLink(destination: ProfileView(), isActive: self.$goToProfile) {
                        
                    }
                    Image("default" )
                        .resizable()
                        .frame(width: 41.0, height: 41.0)
                        .padding(EdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 20.0)
                        )
                        .foregroundColor(.black)
                        .onTapGesture {
                            print("Profile Tap \(self.goToProfile)")
                            self.goToProfile.toggle()
                        }
                })
        }).onAppear(perform: {
            Task {
                dbManager.dropTable()
                await fetchPopularGame()
            }
        }).task {
        }
        
        
    }
    
    func fetchPopularGame() async {
        let network = NetworkService()
        do {
            gameViewModel.listGame = try await network.getPopularGames()
        } catch {
            fatalError("Error: connection failed.")
        }
    }
    
}

#Preview {
    ContentView()
}
