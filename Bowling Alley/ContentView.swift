//
//  ContentView.swift
//  Bowling Alley
//
//  Created by Marcel Mierzejewski on 05/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var gameState = GameState()
    @State private var selection = 0
 
    var body: some View {
        TabView(selection: $selection) {
            ScoreboardView()
                .tabItem {
                    VStack {
                        Image(systemName: "sunset.fill")
                        Text("Game on!")
                    }
                }
                .tag(0)
            LeaderboardView()
                .tabItem {
                    VStack {
                        Image(systemName: "person.2.square.stack.fill")
                        Text("Leaderboards")
                    }
                }
                .tag(1)
        }
        .environmentObject(gameState)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
