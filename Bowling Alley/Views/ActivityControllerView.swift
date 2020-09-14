//
//  ActivityControllerView.swift
//  Bowling Alley
//
//  Created by Marcel Mierzejewski on 09/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import Foundation
import SwiftUI

public struct ActivityControllerView: UIViewControllerRepresentable {
    
    public let activityItems: [Any]
    public let applicationActivities: [UIActivity]?
    
    public init(activityItems: [Any], applicationActivities: [UIActivity]?) {
        self.activityItems = activityItems
        self.applicationActivities = applicationActivities
    }
    
    public func makeUIViewController(context: Context) -> UIActivityViewController {
        return UIActivityViewController(activityItems: activityItems,
                                        applicationActivities: applicationActivities)
    }
    
    public func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        //
    }
}
