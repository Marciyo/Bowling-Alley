//
//  ScoreboardView.swift
//  Bowling Alley
//
//  Created by Marcel Mierzejewski on 05/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import SwiftUI

struct ScoreboardView: View {
    @EnvironmentObject var gameState: GameState
    @State private var presentedSheet: Sheet.SheetType?

    private var settingsButton: some View {
        Button(action: { self.presentedSheet = .settings } ) {
            Image(systemName: "gear")
                .style(appStyle: .barButton)
                .foregroundColor(Color(.label))
        }
        .buttonStyle(BorderedBarButtonStyle())
        .accentColor(Color(.label).opacity(0.1))
    }
    
    private var addRollButton: some View {
        Button(action: { self.gameState.players[0].addRoll(pinsKnocked: 3) } ) {
            Image(systemName: "plus")
                .style(appStyle: .barButton)
                .foregroundColor(Color(.label))
        }
        .buttonStyle(BorderedBarButtonStyle())
        .accentColor(Color(.label).opacity(0.1))
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HStack {
                    ForEach(0..<gameState.players.count) { row in
                        Spacer()
                        Text(self.gameState.players[row].name)
                    }
                }.frame(width: 375, height: 40, alignment: .trailing)
                
                HStack {
                    GeometryReader { geometry in
                        VStack {
                            ForEach(0..<10) { row in
                                Text("\(row + 1)")
                                    .frame(height: geometry.size.height / 10,
                                           alignment: .center)
                            }
                        }
                    }
                    .frame(width: 26)
                    
                    ForEach(0..<gameState.players.count) { row in
                        FramesColumnView()
                    }
                }
                .padding(8)
                .navigationBarTitle("Game on!", displayMode: .inline)
            }
            .navigationBarItems(leading: addRollButton, trailing: settingsButton)
            .sheet(item: $presentedSheet, content: { Sheet(sheetType: $0) })
        }
    }
}

struct ScoreboardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ScoreboardView()
                .environmentObject(GameState())
        }
    }
}

struct FramesColumnView: View {
    var body: some View {
        VStack(alignment: .center, spacing: -1) {
            ForEach(0..<9) { row in
                FrameRowView(firstShot: 2, secondShot: 4, total: 6)
            }
            LastFrameRowView(firstShot: 2, secondShot: 4, thirdShot: 1, total: 7)
        }
    }
}

struct FrameRowView: View {
    @State var firstShot: Int
    @State var secondShot: Int
    @State var total: Int
    
    var fontSize: CGFloat = 20
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                VStack {
                    HStack(spacing: 0) {
                        Text("\(self.firstShot)")
                            .font(.system(size: self.fontSize))
                            .frame(width: geometry.size.width / 2,
                                   height: geometry.size.height / 2,
                                   alignment: .center)
                        Text("\(self.secondShot)")
                            .font(.system(size: self.fontSize))
                            .frame(width: geometry.size.width / 2 ,
                                   height: geometry.size.height / 2,
                                   alignment: .center)
                            .border(Color.black, width: 2)
                        
                    }
                    Text("\(self.total)")
                        .font(.system(size: self.fontSize + 2))
                        .fontWeight(.semibold)
                        .frame(width: geometry.size.width,
                               height: geometry.size.height / 2,
                               alignment: .center)
                        .background(Color.gray)
                }
            }
            .border(Color.black, width: 2)
        }
        .frame(minWidth: 0, maxWidth: .infinity,
               minHeight: 0, maxHeight: .infinity,
               alignment: .center)
    }
}

struct LastFrameRowView: View {
    @State var firstShot: Int
    @State var secondShot: Int
    @State var thirdShot: Int
    @State var total: Int
    
    var fontSize: CGFloat = 20
    
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                VStack {
                    HStack(spacing: -2) {
                        Text("\(self.firstShot)")
                            .font(.system(size: self.fontSize))
                            
                            .frame(width: geometry.size.width / 3,
                                   height: geometry.size.height / 2,
                                   alignment: .center)
                        Text("\(self.secondShot)")
                            .font(.system(size: self.fontSize))
                            
                            .frame(width: geometry.size.width / 3,
                                   height: geometry.size.height / 2,
                                   alignment: .center)
                            .border(Color.black, width: 2)
                        
                        Text("\(self.thirdShot)")
                            .font(.system(size: self.fontSize))
                            
                            .frame(width: geometry.size.width / 3,
                                   height: geometry.size.height / 2,
                                   alignment: .center)
                            .border(Color.black, width: 2)
                        
                    }.offset(x: 2)
                    Text("Total: \(self.total)")
                        .font(.system(size: self.fontSize + 2))
                        .fontWeight(.semibold)
                        .frame(width: geometry.size.width,
                               height: geometry.size.height / 2,
                               alignment: .center)
                        .font(.headline)
                        .background(Color.green)
                }
            }
            .border(Color.black, width: 2)
        }
        .frame(minWidth: 0, maxWidth: .infinity,
               minHeight: 0, maxHeight: .infinity,
               alignment: .center)
    }
}
