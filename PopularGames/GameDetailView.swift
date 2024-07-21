//
//  GameDetailView.swift
//  PopularGames
//
//  Created by WDT on 21/07/24.
//

import SwiftUI

struct GameDetailView: View {
    var game: Game
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
                    Text("Created At: \(game.releasedDate)")
                        .foregroundColor(Color(uiColor: .text))

                        .font(.system(size: 20))
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                    
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
