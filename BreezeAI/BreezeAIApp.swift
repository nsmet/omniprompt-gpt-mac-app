//
//  BreezeAIApp.swift
//  BreezeAI
//
//  Created by Saqib Omer on 12/05/2023.
//

import SwiftUI
import Core
import HotKey

@main
struct BreezeAIApp: App {
    
    @Environment(\.openWindow) var settingWindow
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    @ObservedObject var appState = AppState()
    
    let hotKey = HotKey(key: .b, modifiers: [.command, .shift], keyDownHandler: {
        NSApplication.shared.activate(ignoringOtherApps: true)
        NSApp.windows.first?.orderFrontRegardless()
        
    })
    
    var body: some Scene {
        
        WindowGroup {
            switch appState.router {
            case .settingsView:
                SettingView(settingVM: .init())
            default:
                ContentView(contentVM: .init())
            }
        }
        
        
        MenuBarExtra("", systemImage: "checkerboard.rectangle") {
            Button("Open BreezeAI") {
                appState.router = .contentView
            }
            Button("Setting") {
                appState.router = .settingsView
            }
            
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }.keyboardShortcut("q")
        }
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

