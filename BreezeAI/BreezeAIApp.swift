//
//  BreezeAIApp.swift
//  BreezeAI
//
//  Created by Saqib Omer on 12/05/2023.
//

import SwiftUI
import Core

@main
struct BreezeAIApp: App {
    
    @Environment(\.openWindow) var settingWindow
    
    var body: some Scene {
        WindowGroup {
            ContentView(contentVM: ContentViewModel())
            
        }
        MenuBarExtra("", systemImage: "checkerboard.rectangle") {
            
            
            Button("Setting") {
                settingWindow(id: "settings")
            }
            
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }.keyboardShortcut("q")
            
            
        }
        Window("Settings", id: "settings") {
            SettingView(settingVM: SettingViewModel())
        }
    }
}
