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
//                let systemWideElement = AXUIElementCreateSystemWide()
//                var focusedElement : AnyObject?
//
//                let error = AXUIElementCopyAttributeValue(systemWideElement, kAXFocusedUIElementAttribute as CFString, &focusedElement)
//                if (error != .success){
//                    print("Couldn't get the focused element. Probably a webkit application")
//                } else {
//                    var selectedRangeValue : AnyObject?
//                    let selectedRangeError = AXUIElementCopyAttributeValue(focusedElement as! AXUIElement, kAXSelectedTextRangeAttribute as CFString, &selectedRangeValue)
//                    if (selectedRangeError == .success){
//
//                        if let text = AXUIElement.focusedElement?.selectedText {
//                            AppState.shared.shouldPerformCommand = true
//                            AppState.shared.selectedText = text
//                        }
//
//                    }
//                }
//                let event1 = CGEvent(keyboardEventSource: nil, virtualKey: 0x08, keyDown: true); // cmd-c down
//                event1?.flags = CGEventFlags.maskCommand;
//                event1?.post(tap: CGEventTapLocation.cghidEventTap)
//                
//                let event2 = CGEvent(keyboardEventSource: nil, virtualKey: 0x08, keyDown: false); // cmd-c up
//                event2?.post(tap: CGEventTapLocation.cghidEventTap)
//                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                    if let pastBoard = NSPasteboard.general.string(forType: .string) {
//                        AppState.shared.selectedText = pastBoard
//                    }
//                }
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
        guard let window = NSApplication.shared.windows.first else { assertionFailure(); return }
        window.titlebarAppearsTransparent = true
        window.titleVisibility = .hidden
        window.standardWindowButton(.zoomButton)?.isHidden = true
        window.standardWindowButton(.miniaturizeButton)?.isHidden = true
        window.standardWindowButton(.closeButton)?.isHidden = true
        window.isReleasedWhenClosed = false
        window.delegate = self
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

