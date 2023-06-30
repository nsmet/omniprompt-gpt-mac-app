import Foundation
import SwiftUI

public final class WindowManager {
    public static let shared = WindowManager()
    
    let promptOnlyheight = CGFloat(125)
    public let promptAndResponsHeight = CGFloat(125 + 250 + 50)
    let windowWidth = CGFloat(752)
    
    private init() {
        // private to prevent others from using the default '()' initializer
    }
    
    func setWindowFrame(small: Bool) {
        if let window = NSApp.windows.first {
            // Calculate the window position
            let screenWidth = NSScreen.main?.frame.width ?? 1080
            let screenHeight = NSScreen.main?.frame.height ?? 752

            let windowWidth = CGFloat(752) // your desired window width

            // Determine the window's y-coordinate
            var y: CGFloat = 0
            let x = (screenWidth / 2) - (windowWidth / 2) // Center the window horizontally
            var windowHeight: CGFloat = 0
            windowHeight = CGFloat(small ? promptOnlyheight : promptAndResponsHeight)
            
            y = (screenHeight / 2) + (windowHeight / 2) + 60 // Position the window slightly above the center vertically

            window.minSize = NSSize(width: CGFloat(752), height: promptOnlyheight)
            window.maxSize = NSSize(width: CGFloat(1080), height: CGFloat(1000))
        }
    }
}
