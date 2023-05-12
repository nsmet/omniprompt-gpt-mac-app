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

    var body: some Scene {
        WindowGroup {
            ContentView(contentVM: ContentViewModel())
            
        }
        MenuBarExtra("", systemImage: "checkerboard.rectangle") {
            
            Link("Open BreezeAI", destination: URL(string: "https://apple.com")!)
                .keyboardShortcut("G")
            Link("Settings", destination: URL(string: "https://google.com")!)
            
            
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }.keyboardShortcut("q")
            
            
        }
    }
}
