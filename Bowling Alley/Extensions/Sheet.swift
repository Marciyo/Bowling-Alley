//
//  Sheet.swift
//  Bowling Alley
//
//  Created by Marcel Mierzejewski on 09/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import SwiftUI

struct Sheet: View {
    enum SheetType: Identifiable {
        case share(content: [Any])
        case settings, about
        
        var id: String {
            switch self {
            case .share:
                return "share"
            case .about:
                return "about"
            case .settings:
                return "settings"
            }
        }
    }
    
    let sheetType: SheetType
    
    private func make() -> some View {
        switch sheetType {
            // To be used to share scores int the future etc.
        case .share(let content):
            return AnyView(ActivityControllerView(activityItems: content,
                                                  applicationActivities: nil))
        case .about:
            return AnyView(AboutView())
        case .settings:
            return AnyView(SettingsView())
        }
    }
    
    var body: some View {
        make()
            .environmentObject(GameState.shared)
    }
}
