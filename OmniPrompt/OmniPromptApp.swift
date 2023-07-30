//
//  OmniPromptApp.swift
//  OmniPrompt
//
//  Created by Nick Smet on 12/05/2023.
//

import SwiftUI
import Core
import HotKey
import Foundation

@main
struct OmniPromptApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    @StateObject var appState = AppState.shared
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        let _ = NSApplication.shared.setActivationPolicy(.accessory)

        WindowGroup {
            switch appState.router {
                case .settingsView:
                    SettingView()
                case .contentView:
                    ContentView(contentVM: .init(appState: AppState.shared))
                        .environmentObject(AppState.shared)
                default:
                    ContentView(contentVM: .init(appState: AppState.shared))
                        .environmentObject(AppState.shared)
            }
        }
        .windowStyle(HiddenTitleBarWindowStyle())
        .windowResizability(.contentSize)
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
            } else if newPhase == .inactive {
            } else if newPhase == .background {
            }
        }
        
        MenuBarExtra("", image: "menuBarIcon") {
            Button("Open OmniPrompt") {
                appState.router = .contentView
                appDelegate.openOmniPrompt()
            }.keyboardShortcut("b", modifiers: [.command, .shift])
            
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
           WindowManager.shared.setWindowFrame(small: AppState.shared.messages.count == 0)
       }
   }
    
    private func handleKeyDown() {
        // if we already have state in the input -> don't do it
        if (AppState.shared.promptText.isEmpty) {
            let oldClipBoardContent = NSPasteboard.general.string(forType: .string)
            
            NSPasteboard.general.clearContents()
            let event1 = CGEvent(keyboardEventSource: nil, virtualKey: 0x08, keyDown: true); // cmd-c down
            event1?.flags = CGEventFlags.maskCommand;
            event1?.post(tap: CGEventTapLocation.cghidEventTap)
            
            let event2 = CGEvent(keyboardEventSource: nil, virtualKey: 0x08, keyDown: false); // cmd-c up
            event2?.post(tap: CGEventTapLocation.cghidEventTap)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                if let pastBoard = NSPasteboard.general.string(forType: .string) {
                        AppState.shared.promptText = pastBoard
                        AppState.shared.originalSelectedText = pastBoard
                }
                
                // If we have content in our pasteboard, set it back
                if let oldContent = oldClipBoardContent, !oldContent.isEmpty {
                    NSPasteboard.general.setString(oldContent, forType: .string)
                }
            }
        }
        
        NSApp.activate(ignoringOtherApps: true)
        NSApp.windows.first?.orderFrontRegardless()
    }
    
    func openOmniPrompt() {
        AppState.shared.promptText = ""
        setWindowFrame()
        handleKeyDown()
        
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
