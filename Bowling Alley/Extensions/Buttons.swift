//
//  Buttons.swift
//  Bowling Alley
//
//  Created by Marcel Mierzejewski on 09/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import SwiftUI

public struct BorderedBarButtonStyle: ButtonStyle {
    public init() { }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .padding(10)
            .background(RoundedRectangle(cornerRadius: 14, style: .continuous).foregroundColor(Color.accentColor))
            .accentColor(.blueYonder)
    }
}

public struct PlainRoundedButton: ButtonStyle {
    public init() { }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(configuration.isPressed ? .gray : Color.accentColor)
            .animation(.easeOut(duration: 0.2))
            .cornerRadius(8)
            .accentColor(.blueYonder)
    }
}

public extension Image {
    enum AppImageStyle {
        case barButton
    }
    
    func style(appStyle: AppImageStyle) -> some View {
        switch appStyle {
        case .barButton: return barButton()
        }
    }
}

extension Image {
    private func barButton() -> some View {
        self.imageScale(.medium)
            .font(.system(size: 18, weight: .regular, design: .rounded))
    }
}
