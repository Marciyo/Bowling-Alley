//
//  LeaderboardView.swift
//  Bowling Alley
//
//  Created by Marcel Mierzejewski on 05/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import SwiftUI

struct LeaderboardView: View {
    @State private var presentedSheet: Sheet.SheetType?
    
    private var aboutButton: some View {
        Button(action: { self.presentedSheet = .about } ) {
            Image(systemName: "info.circle")
                .style(appStyle: .barButton)
                .foregroundColor(Color(.label))
        }
        .buttonStyle(BorderedBarButtonStyle())
        .accentColor(Color(.label).opacity(0.1))
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(0..<20) { row in
                    Section {
                        LeaderboardListRow(name: "Player name", date: "03/11/2020", points: 100 + row)
                        
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
            .navigationBarTitle("Leaderboard")
            .navigationBarItems(trailing: aboutButton)
            .sheet(item: $presentedSheet, content: { Sheet(sheetType: $0) })
        }
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
    }
}

struct LeaderboardListRow: View {
    let name: String
    let date: String
    let points: Int
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text(name)
                        .font(.headline)
                    Spacer()
                }
                HStack {
                    Text(date)
                        .font(.footnote)
                    Spacer()
                }
            }
            Spacer()
            Text("\(points)")
                .font(.largeTitle)
        }
    }
}
