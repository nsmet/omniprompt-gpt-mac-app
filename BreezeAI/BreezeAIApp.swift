//
//  BreezeAIApp.swift
//  BreezeAI
//
//  Created by Saqib Omer on 12/05/2023.
//

import SwiftUI
import Core
import HotKey
import Foundation

@main
struct BreezeAIApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    @StateObject var appState = AppState.shared
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        let _ = NSApplication.shared.setActivationPolicy(.accessory)
        WindowGroup{
            switch appState.router {
            case .settingsView:
                SettingView(settingVM: .init())
            case .done:
                ContentView(contentVM: .init())
            default:
                ContentView(contentVM: .init())
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                
            } else if newPhase == .inactive {
//                print("Inactive")
            } else if newPhase == .background {
//                print("Background")
            }
        }
        
        MenuBarExtra("", image: "menuBarIcon") {
            Button("Open OmniPrompt") {
                appDelegate.openBreezeAI()
                appState.router = .contentView
            }
            
            Button("Settings") {
                NSApplication.shared.activate(ignoringOtherApps: true)
                NSApp.windows.first?.orderFrontRegardless()
                appState.router = .settingsView
            }
            
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }.keyboardShortcut("q")
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {
    let pasteBoard = NSPasteboard.general
    var hotKey: HotKey? = nil
    
    override init() {
       super.init()

       // Initialize hotKey here
       hotKey = HotKey(key: .b, modifiers: [.command, .shift], keyDownHandler: {
           self.handleKeyDown()
       })
   }
    
    @MainActor func applicationDidFinishLaunching(_ notification: Notification) {
        if let window = NSApp.windows.first {
            //hide buttons
            window.standardWindowButton(.closeButton)?.isHidden = true
            window.standardWindowButton(.miniaturizeButton)?.isHidden = true
            window.standardWindowButton(.zoomButton)?.isHidden = true
            
            setWindowFrame()
        }
        NSApplication.shared.hide(nil)
    }
    
    func applicationDidResignActive(_ notification: Notification) {
        NSApplication.shared.hide(nil)
    }
    
    private func setWindowFrame() {
       if let window = NSApp.windows.first {
           window.titleVisibility = .hidden
           window.titlebarAppearsTransparent = true
           window.backgroundColor = .clear
           window.hasShadow = false
           window.isOpaque = false
           
           WindowManager.shared.setWindowFrame(resultVisible: false)
       }
   }
    
    private func handleKeyDown() {
        NSPasteboard.general.clearContents()
        let event1 = CGEvent(keyboardEventSource: nil, virtualKey: 0x08, keyDown: true); // cmd-c down
        event1?.flags = CGEventFlags.maskCommand;
        event1?.post(tap: CGEventTapLocation.cghidEventTap)
        
        let event2 = CGEvent(keyboardEventSource: nil, virtualKey: 0x08, keyDown: false); // cmd-c up
        event2?.post(tap: CGEventTapLocation.cghidEventTap)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            if let pastBoard = NSPasteboard.general.string(forType: .string) {
                
                if pastBoard.compare(AppState.shared.originalSelectedText, options: .caseInsensitive) != .orderedSame {
                    AppState.shared.promptText = pastBoard
                    AppState.shared.originalSelectedText = pastBoard
                }
                
            }
            NSPasteboard.general.clearContents()
        }
        
        NSApp.activate(ignoringOtherApps: true)
        //        NSApplication.shared.unhide(nil)
        NSApp.windows.first?.orderFrontRegardless()
    }
    
    func openBreezeAI() {
        AppState.shared.promptText = ""
        setWindowFrame()
        
        NSApplication.shared.activate(ignoringOtherApps: true)
        NSApp.windows.first?.orderFrontRegardless()
    }
}

extension AppDelegate: NSWindowDelegate {
    func windowShouldClose(_ sender: NSWindow) -> Bool {
        NSApp.hide(nil)
        return false
    }
}
