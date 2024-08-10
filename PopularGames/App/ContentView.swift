//
//  ContentView.swift
//  PopularGames
//
//  Created by WDT on 21/07/24.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var homePresenter: HomePresenter
  
  var body: some View {
    NavigationStack {
      HomeView(presenter: homePresenter)
    }
  }
}
