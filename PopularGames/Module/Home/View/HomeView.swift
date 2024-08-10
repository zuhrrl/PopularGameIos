//
//  ContentView.swift
//  PopularGames
//
//  Created by WDT on 21/07/24.
//

import SwiftUI

struct HomeView: View {
  @ObservedObject var presenter: HomePresenter
  
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
      
      else {
        Text("Popular Games")
          .font(.headline)
          .padding(EdgeInsets(top: 0.0, leading: 35.0, bottom: 0, trailing: 0)
          )
          .foregroundColor(Color(uiColor: .text))
          .font(.system(size: 16, weight: .bold))
          .padding(EdgeInsets(top: 15, leading: 0, bottom: 0, trailing: 0))
        List(presenter.listGame, id: \.id) {  item in
          ItemCardGame(game: item, isFavorite:  item.isFavorite, onTapFavorite: {
            debugPrint("ON TAP FAVORITE")
            presenter.addToFavorite(item: item)

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
    .navigationBarItems(
      leading: NavigationLink(destination: presenter.favoriteGameView) {
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
        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))
      },
      trailing:  NavigationLink(destination: ProfileView(), label: {
        Image("default" )
          .resizable()
          .frame(width: 41.0, height: 41.0)
          .padding(EdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 20.0)
          )
          .foregroundColor(.black)
        
      })
    )
    .onAppear(perform: {
      presenter.fetchPopularGames()
    })
  }
}
//
//#Preview {
//  ContentView()
//}
