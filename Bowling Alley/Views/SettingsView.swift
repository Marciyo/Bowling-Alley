//
//  SettingsView.swift
//  Bowling Alley
//
//  Created by Marcel Mierzejewski on 09/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
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
    
    var body: some View {
        NavigationView {
            List {
                Text("Username")
                .padding()
                .background(Color(.quaternarySystemFill))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            }
            .listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
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
