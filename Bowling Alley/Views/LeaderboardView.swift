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
    
    var body: some View {
        NavigationView {
            List {
                ForEach(0..<20) { row in
                    Group {
                        LeaderboardListRow(name: "Player name", date: .distantPast, points: 100 + row)
//                    Divider()
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
            .navigationBarTitle("Leaderboard")
            .navigationBarItems(leading: shareButton, trailing: aboutButton)
            .sheet(item: $presentedSheet, content: { Sheet(sheetType: $0) })
        }
    }
}

// MARK: - NavigationBarItems

extension LeaderboardView {
    private var aboutButton: some View {
        Button(action: { self.presentedSheet = .about } ) {
            Image(systemName: "info.circle")
                .style(appStyle: .barButton)
                .foregroundColor(Color(.label))
        }
        .buttonStyle(BorderedBarButtonStyle())
        .accentColor(Color(.label).opacity(0.1))
    }
    
    private var shareButton: some View {
        Button(action: { self.presentedSheet = .share(content: [Date()]) } ) {
            Image(systemName: "square.and.arrow.up.fill")
                .style(appStyle: .barButton)
                .foregroundColor(Color(.label))
        }
        .buttonStyle(BorderedBarButtonStyle())
        .accentColor(Color(.label).opacity(0.1))
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
    }
}

struct LeaderboardListRow: View {
    let name: String
    let date: Date
    let points: Int
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text(name)
                        .font(.headline)
                    Spacer()
                }
                HStack {
                    Text("\(date, formatter: Self.dateFormatter)")
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
