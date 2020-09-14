//
//  AboutView.swift
//  Bowling Alley
//
//  Created by Marcel Mierzejewski on 09/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import SwiftUI

struct AboutView: View {
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
            VStack {
                List {
                    Text("I used TDD to develop both scoring systems as well as frame generation. It took me three evenings\n\nI wanted to use SwiftUI to do the layout because it's self-development for me. It wasn't super easy though. Instead of GeometryReader, I have to use key preferences to get the self-sizing behaviour correctly, but I didn't have time to do it yet.\n\nAnyway I think that with just a little bit more of work I can hopefully get it done. SwiftUI is very fast and rewarding for simple layouts, but when you want something a bit more complicated it's not so easy. I want to learn it anyway so that next time prototyping the layout will go like a breeze.\n\nFor now I'll use another approach to scoreboard screen. Let's try Diffable Data Sources and collection view. That one is also new and cool. We will see how this approach works")
                }.listStyle(GroupedListStyle())
                
                Text("Made with ❤️ by Marcel")
                    .multilineTextAlignment(.center)
                    .padding()
            }
                
            .environment(\.horizontalSizeClass, .regular)
            .navigationBarTitle(Text("About"), displayMode: .inline)
            .navigationBarItems(leading: dismissButton)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
