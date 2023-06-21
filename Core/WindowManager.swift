//
//  WindowManager.swift
//  Core
//
//  Created by Nick Smet on 20/06/2023.
//

import Foundation
import SwiftUI

public final class WindowManager {
    public static let shared = WindowManager()
    
    let promptOnlyheight = 125
    public let promptAndResponsHeight = 125 + 250 + 50
    let windowWidth = 752
    
    private init() {
        // private to prevent others from using the default '()' initializer
    }
    
    func setWindowFrame(resultVisible: Bool) {
        if let window = NSApp.windows.first {
            // Calculate the window position
            let screenWidth = NSScreen.main?.frame.width ?? 1080
            let screenHeight = NSScreen.main?.frame.height ?? 1080

            let windowWidth = 752 // your desired window width

            // Determine the window's y-coordinate
            var y: CGFloat = 0
            let x = (Int(screenWidth) / 2) - (windowWidth / 2) // Center the window horizontally
            var windowHeight: CGFloat = 0

            windowHeight = CGFloat(promptOnlyheight)
            y = (screenHeight / 2) + (windowHeight / 2) + 60 // Position the window slightly above the center verticallyı
            // Set the window's frame
            window.setFrame(CGRect(x: CGFloat(x), y: y, width: CGFloat(windowWidth), height: windowHeight), display: true)
        }
    }
}
