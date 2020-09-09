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
                    Text("More info about how the app was develop etc.\n\nI used TDD to develop both Scoring system as well as Frame generation. It took me three evenings\n\nI wanted to use SwiftUI to do the layout because it's self-developement for me. I hope we can use it more in the Totem project together :)")
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
