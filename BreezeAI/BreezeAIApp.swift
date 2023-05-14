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
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
        
        WindowGroup {
            ContentView(contentVM: ContentViewModel())
            
        }
        
        
//        MenuBarExtra("", systemImage: "checkerboard.rectangle") {
//
//
//            Button("Setting") {
//                settingWindow(id: "settings")
//            }
//
//            Button("Quit") {
//                NSApplication.shared.terminate(nil)
//            }.keyboardShortcut("q")
//
//
//        }
//        Window("Settings", id: "settings") {
//            SettingView(settingVM: SettingViewModel())
//        }
//        .windowStyle(HiddenTitleBarWindowStyle())
    }
}

class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {
    
    @MainActor func applicationDidFinishLaunching(_ notification: Notification) {
        guard let window = NSApplication.shared.windows.first else { assertionFailure(); return }
        window.titlebarAppearsTransparent = true
        window.titleVisibility = .hidden
        window.standardWindowButton(.zoomButton)?.isHidden = true
        window.standardWindowButton(.miniaturizeButton)?.isHidden = true
        window.standardWindowButton(.closeButton)?.isHidden = true
        
    }
    
}

