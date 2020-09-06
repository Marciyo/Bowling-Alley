//
//  NewGamePopupView.swift
//  Bowling Alley
//
//  Created by Marcel Mierzejewski on 05/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import SwiftUI

struct NewGamePopupView: View {
    var onePlayerButton: some View = {
        Button(action: {
            print("Single tapped!")
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
    }()
    
    var twoPlayersButton: some View = {
        Button(action: {
            print("Duo tapped!")
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
    }()
    
    var body: some View {
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
        }.background(Color.blueYonder)
    }
}

struct NewGamePopupView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NewGamePopupView()
                .previewLayout(.fixed(width: 300, height: 300))
        
            //
        }
    }
}
//
//struct LabelButtonStyle: ButtonStyle {
//    
//    var scaleAmount: CGFloat
//
//    func makeBody(configuration: Self.Configuration) -> some View {
//        LabelButton(
//            configuration: configuration,
//            scaleAmount: scaleAmount
//        )
//    }
//}
//
//private extension LabelButtonStyle {
//    struct LabelButton: View {
//
//        @Environment(\.isEnabled) var isEnabled
//
//        let configuration: LabelButtonStyle.Configuration
//        let scaleAmount: CGFloat
//
//        var body: some View {
//            return configuration.label
//                .font(.title)
//                .padding()
//                .background(Color.naplesYellow)
//                .cornerRadius(16)
//                
//                .opacity(configuration.isPressed ? 0.5 : 1.0)
//                .scaleEffect(configuration.isPressed ? scaleAmount : 1.0)
//                .foregroundColor(isEnabled ? .smokyBlock : .gray)
//        }
//    }
//}
