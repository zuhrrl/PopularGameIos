//
//  ItemFavoriteGame.swift
//  PopularGames
//
//  Created by WDT on 27/07/24.
//

import SwiftUI

struct ItemFavoriteGame: View {
  var game: GameEntity
  var isFavorite: Bool = false
  var onTap: () -> Void
  var body: some View {
    HStack {
      AsyncImage(url: URL(string: "\(game.backgroundImage)")) { image in
        image.resizable()
      } placeholder: {
        ProgressView()
          .tint(.white)
      }
      .frame(width: 80.0, height: 80.0)
      .clipShape(.rect(cornerRadius: 15))
      .padding(10)
      VStack(
        alignment: .leading, content: {
          Text("\(game.title)")
            .font(.system(size: 14, weight: .bold))
            .padding(EdgeInsets(top: 0.0, leading: 0, bottom: 0, trailing: 0)
            )
            .foregroundColor(Color(uiColor: .text))
          
          Text("\(game.genres)")
            .font(.system(size: 13))
            .padding(EdgeInsets(top: 0.0, leading: 0, bottom: 0, trailing: 0)
            ).truncationMode(/*@START_MENU_TOKEN@*/.tail/*@END_MENU_TOKEN@*/)
            .lineLimit(1)
            .foregroundColor(Color(uiColor: .text))
          Text("Released: \(game.releasedDate)")
            .font(.system(size: 12))
            .padding(EdgeInsets(top: 0.0, leading: 0, bottom: 0, trailing: 0)
            ).truncationMode(/*@START_MENU_TOKEN@*/.tail/*@END_MENU_TOKEN@*/)
            .lineLimit(1)
            .foregroundColor(Color(uiColor: .text))
          Text("Rating: \(String(format: "%.2f", game.rating))")
            .font(.system(size: 12))
            .padding(EdgeInsets(top: 0.0, leading: 0, bottom: 0, trailing: 0)
            ).truncationMode(/*@START_MENU_TOKEN@*/.tail/*@END_MENU_TOKEN@*/)
            .lineLimit(1)
            .foregroundColor(Color(uiColor: .text))
        }
      )
      Spacer()
      Image(systemName: "minus.circle")
        .resizable()
        .frame(width: 25.0, height: 25.0)
        .padding(EdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 20.0)
        )
        .foregroundColor(.white)
        .onTapGesture {
          onTap()
        }
    }
    .background(Color(uiColor: .secondary))
    .foregroundColor(.gray)
    .frame( height: 98)
    .cornerRadius(15)
    .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
    
  }
}
