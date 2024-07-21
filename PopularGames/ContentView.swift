//
//  ContentView.swift
//  PopularGames
//
//  Created by WDT on 21/07/24.
//

import SwiftUI

struct ContentView: View {
    @State private var goToProfile: Bool = false
    @State private var listGame: [Game] = []
    @State var selectedGame: Int? = nil
    var body: some View {
        NavigationView(content: {
            
            VStack(alignment: .leading) {
                Text("Popular Games")
                    .font(.subheadline)
                    .padding(EdgeInsets(top: 0.0, leading: 35.0, bottom: 0, trailing: 0)
                    )
                    .foregroundColor(Color(uiColor: .text))
                    .font(.system(size: 16, weight: .bold))
                
                
                List(listGame, id: \.id) { item in
                    
                    ItemCardGame(game: item)
                        .listRowBackground(Color.clear) // Change Row Color
                        .listRowSeparator(.hidden)
                        .onTapGesture {
                            self.selectedGame = item.id
                        }
                        .overlay {
                            NavigationLink(destination: GameDetailView(game: item), tag: item.id, selection: $selectedGame) {
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
            .navigationBarItems(trailing:  Button {
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
                await fetchPopularGame()
            }
        })
        
    }
    
    func fetchPopularGame() async {
        let network = NetworkService()
        do {
            listGame = try await network.getPopularGames()
        } catch {
            fatalError("Error: connection failed.")
        }
    }
    
}

#Preview {
    ContentView()
}
