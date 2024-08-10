//
//  FavoriteGameView.swift
//  PopularGames
//
//  Created by WDT on 27/07/24.
//

import SwiftUI

struct FavoriteGameView: View {
  @ObservedObject var presenter: FavoriteGamePresenter
  
  var body: some View {
    VStack(alignment: .leading) {
      if presenter.loadingState {
        HStack {
          Spacer()
          VStack {
            Text("Loading...")
              .foregroundColor(Color(uiColor: .text))
            ProgressView()
              .tint(.white)
          }
          Spacer()
        }
      }
      
      else if presenter.favoriteGame.isEmpty {
        Text("Favorite Games")
          .font(.headline)
          .padding(EdgeInsets(top: 0.0, leading: 35.0, bottom: 0, trailing: 0)
          )
          .foregroundColor(Color(uiColor: .text))
          .font(.system(size: 16, weight: .bold))
          .padding(EdgeInsets(top: 15, leading: 0, bottom: 0, trailing: 0))
        Spacer()
        HStack {
          
          Spacer()
          VStack {
            Text("Favorite game is empty!")
              .foregroundColor(Color(uiColor: .text))
          }
          Spacer()
        }
        Spacer()
      }
      
      else {
        Text("Favorite Games")
          .font(.headline)
          .padding(EdgeInsets(top: 0.0, leading: 35.0, bottom: 0, trailing: 0)
          )
          .foregroundColor(Color(uiColor: .text))
          .font(.system(size: 16, weight: .bold))
          .padding(EdgeInsets(top: 15, leading: 0, bottom: 0, trailing: 0))
        List(presenter.favoriteGame, id: \.id) {  item in
          ItemFavoriteGame(game: item, onTap: {
            debugPrint("TRYING TO DELETE FAVORITE GAME FROM FAVORITE SCREEN with ID \(item.id)")
            presenter.deleteFavoriteGame(item: item)
          })
          .listRowBackground(Color.clear) // Change Row Color
          .listRowSeparator(.hidden)
          .onTapGesture {
            presenter.selectedGame = item.id
          }
          .overlay {
            NavigationLink(destination: presenter.gameDetailView(gameEntity: item), tag: item.id, selection: $presenter.selectedGame) {
              EmptyView().frame(height: 0)
            }.opacity(0)
          }
        }.listStyle(.plain) //Change ListStyle
          .scrollContentBackground(.hidden)
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background {
      Color.init(uiColor: .primary)
        .ignoresSafeArea()
    }
    .onAppear(perform: {
      presenter.fetchFavoriteGame()
    })
  }
}
