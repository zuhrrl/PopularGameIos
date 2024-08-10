//
//  PopularGamesApp.swift
//  PopularGames
//
//  Created by WDT on 21/07/24.
//

import SwiftUI

@main
struct PopularGamesApp: App {
  let homePresenter = HomePresenter(homeUseCase: Injection.init().provideHome())
    var body: some Scene {
        WindowGroup {
            ContentView()
            .environmentObject(homePresenter)
        }
    }
}
