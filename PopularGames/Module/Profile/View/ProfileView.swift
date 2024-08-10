//
//  ProfileView.swift
//  PopularGames
//
//  Created by WDT on 21/07/24.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image("zuldicoding")
                    .resizable()
                    .frame(width: 106.0, height: 106.0)
                    .clipShape(Circle())
                    .padding(10)
                Text("Zuhrul Anam")
                    .font(.system(size: 20, weight: .bold))
                    .padding(5)
                    .foregroundColor(Color(uiColor: .text))
                Text("zuhrrlanam@gmail.com")
                    .foregroundColor(Color(uiColor: .text))
                    .tint(Color(uiColor: .text))
                
                Spacer()
            }
            .padding(25)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                Color.init(uiColor: .primary)                           .ignoresSafeArea()
            }
        }
    }
}


#Preview {
    ProfileView()
}
