//
//  ItemCardGame.swift
//  PopularGames
//
//  Created by WDT on 21/07/24.
//

import SwiftUI

struct ItemCardGame: View {
    var game: Game
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: "\(game.imageUrl)")) { image in
                image.resizable()
            } placeholder: {
                Color.gray
            }
            .frame(width: 80.0, height: 80.0)
            .clipShape(.rect(cornerRadius: 15))
            .padding(10)
            VStack(
                alignment: .leading, content: {
                    Text("\(game.title)")
                        .font(.headline)
                        .padding(EdgeInsets(top: 0.0, leading: 0, bottom: 0, trailing: 0)
                        )
                        .foregroundColor(Color(uiColor: .text))

                    Text("\(game.genres)")
                        .font(.subheadline)
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

                    
                }
            )
            Spacer()
            Text(String(format: "%.2f", game.rating))
                .font(.system(size: 16))
                .padding(EdgeInsets(top: 0.0, leading: 10.0, bottom: 0, trailing: 15)
                )
                .foregroundColor(Color(uiColor: .text))

                

        }
        .background(Color(uiColor: .secondary))
        .foregroundColor(.gray)
        .frame( height: 98)
        .cornerRadius(15)
        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))

    }
}

#Preview {
    ContentView()
}
