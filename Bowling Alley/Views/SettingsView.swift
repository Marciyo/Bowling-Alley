//
//  SettingsView.swift
//  Bowling Alley
//
//  Created by Marcel Mierzejewski on 09/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var gameState: GameState
    @Environment(\.presentationMode) private var presentationMode
    
    private var dismissButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "xmark.circle")
                .style(appStyle: .barButton)
                .foregroundColor(Color(.label))
        })
            .buttonStyle(BorderedBarButtonStyle())
    }
    
    private var onePlayerButton: some View {
        Button(action: {
            self.gameState.players = [Player(name: "Player 1")]
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "person.fill")
                Text("Single")
            }
            .font(.title)
            .padding()
            .foregroundColor(.smokyBlock)
            .background(Color.naplesYellow)
            .cornerRadius(16)
        }
    }
    
    private var twoPlayersButton: some View {
        Button(action: {
            self.gameState.players = [Player(name: "Player 1"),
                                      Player(name: "Player 2")]
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "person.2.fill")
                    .font(.title)
                Text("Duo")
                    .fontWeight(.semibold)
                    .font(.title)
            }
            .padding()
            .foregroundColor(.smokyBlock)
            .background(Color.naplesYellow)
            .cornerRadius(16)
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Image("YellowBall")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                Text("Start new game!")
                    .font(.largeTitle)
                Spacer()
                HStack {
                    Spacer()
                    onePlayerButton
                    Spacer()
                    twoPlayersButton
                    Spacer()
                }
                Spacer()
            }
            .edgesIgnoringSafeArea(.all)
            .background(Color.blueYonder)
            .navigationBarTitle(Text("Settings"), displayMode: .inline)
            .navigationBarItems(leading: dismissButton)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
