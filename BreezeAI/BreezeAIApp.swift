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
    
    let hotKey = HotKey(key: .b, modifiers: [.command, .shift], keyDownHandler: {
        
        if let window = NSApp.windows.first {
            //hide title and bar
            AppState.shared.selectedText = ""
            window.titleVisibility = .hidden
            window.titlebarAppearsTransparent = true
            window.backgroundColor = .clear
            window.hasShadow = false
            window.isOpaque = false
            let x = ((NSScreen.main?.frame.width ?? 1080) / 2) - 376
            let y = ((NSScreen.main?.frame.height ?? 1080) / 2) - 37
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if let pastBoard = NSPasteboard.general.string(forType: .string) {
                    var height = pastBoard.height(withConstrainedWidth: 752, font: .systemFont(ofSize: 20))
                    if height > 400 {
                        height = 400
                    }
                    if height < 100 {
                        height = 100
                    }
                    window.setFrame(CGRect(origin: CGPoint(x: x, y: y), size: CGSize(width: 752, height: height)), display: true)
                } else {
                    window.setFrame(CGRect(origin: CGPoint(x: x, y: y), size: CGSize(width: 752, height: 100)), display: true)
                }
            }
            
        }
        NSPasteboard.general.clearContents()
        let event1 = CGEvent(keyboardEventSource: nil, virtualKey: 0x08, keyDown: true); // cmd-c down
        event1?.flags = CGEventFlags.maskCommand;
        event1?.post(tap: CGEventTapLocation.cghidEventTap)
        
        let event2 = CGEvent(keyboardEventSource: nil, virtualKey: 0x08, keyDown: false); // cmd-c up
        event2?.post(tap: CGEventTapLocation.cghidEventTap)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            if let pastBoard = NSPasteboard.general.string(forType: .string) {
                
                if pastBoard.compare(AppState.shared.originalSelectedText, options: .caseInsensitive) != .orderedSame {
                    AppState.shared.selectedText = pastBoard
                    AppState.shared.originalSelectedText = pastBoard
                }
                
            }
            NSPasteboard.general.clearContents()
        }
        
        NSApp.activate(ignoringOtherApps: true)
        //        NSApplication.shared.unhide(nil)
        NSApp.windows.first?.orderFrontRegardless()
        
        
    })
    
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
                print("Inactive")
            } else if newPhase == .background {
                print("Background")
            }
        }
        
        
        
        MenuBarExtra("", image: "menuBarIcon") {
            Button("Open BreezeAI") {
                if let window = NSApp.windows.first {
                    AppState.shared.selectedText = ""
                    //hide title and bar
                    window.titleVisibility = .hidden
                    window.titlebarAppearsTransparent = true
                    window.backgroundColor = .clear
                    window.hasShadow = false
                    window.isOpaque = false
                    let x = ((NSScreen.main?.frame.width ?? 1080) / 2) - 376
                    let y = ((NSScreen.main?.frame.height ?? 1080) / 2) - 37
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        if let pastBoard = NSPasteboard.general.string(forType: .string) {
                            var height = pastBoard.height(withConstrainedWidth: 752, font: .systemFont(ofSize: 20))
                            if height > 400 {
                                height = 400
                            }
                            if height < 100 {
                                height = 100
                            }
                            window.setFrame(CGRect(origin: CGPoint(x: x, y: y), size: CGSize(width: 752, height: height)), display: true)
                        } else {
                            window.setFrame(CGRect(origin: CGPoint(x: x, y: y), size: CGSize(width: 752, height: 100)), display: true)
                        }
                    }
                    
                }
                NSPasteboard.general.clearContents()
                let event1 = CGEvent(keyboardEventSource: nil, virtualKey: 0x08, keyDown: true); // cmd-c down
                event1?.flags = CGEventFlags.maskCommand;
                event1?.post(tap: CGEventTapLocation.cghidEventTap)
                
                let event2 = CGEvent(keyboardEventSource: nil, virtualKey: 0x08, keyDown: false); // cmd-c up
                event2?.post(tap: CGEventTapLocation.cghidEventTap)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    if let pastBoard = NSPasteboard.general.string(forType: .string) {
                        AppState.shared.selectedText = pastBoard
                    }
                    NSPasteboard.general.clearContents()
                }
                NSApplication.shared.activate(ignoringOtherApps: true)
                NSApp.windows.first?.orderFrontRegardless()
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
    
    @MainActor func applicationDidFinishLaunching(_ notification: Notification) {
        if let window = NSApp.windows.first {
            //hide buttons
            window.standardWindowButton(.closeButton)?.isHidden = true
            window.standardWindowButton(.miniaturizeButton)?.isHidden = true
            window.standardWindowButton(.zoomButton)?.isHidden = true
            
            //hide title and bar
            window.titleVisibility = .hidden
            window.titlebarAppearsTransparent = true
            window.backgroundColor = .clear
            window.hasShadow = false
            window.isOpaque = false
            let x = ((NSScreen.main?.frame.width ?? 1080) / 2) - 376
            let y = ((NSScreen.main?.frame.height ?? 1080) / 2) - 37
            window.setFrame(CGRect(origin: CGPoint(x: x, y: y), size: CGSize(width: 752, height: 100)), display: true)
        }
        NSApplication.shared.hide(nil)
    }
    
    func applicationDidResignActive(_ notification: Notification) {
        NSApplication.shared.hide(nil)
    }
    
}

extension AppDelegate: NSWindowDelegate {
    func windowShouldClose(_ sender: NSWindow) -> Bool {
        NSApp.hide(nil)
        return false
    }
}

