//
//  ActionBarView.swift
//  Core
//
//  Created by Nick Smet on 21/06/2023.
//

import SwiftUI
import Core

struct ActionBarView: View {
    @EnvironmentObject var appState: AppState
    @ObservedObject var contentVM: ContentViewModel
    
    var body: some View {
        HStack() {
            if appState.messages.count > 0 {
                Button{
                    let pasteboard = NSPasteboard.general
                    pasteboard.clearContents()
                    pasteboard.setString(appState.messages[appState.messages.count - 1].message, forType: .string)
                    NSApplication.shared.hide(nil)
                    
                } label: {
                    Text("Copy to clipboard ⌘ + d")
                        .font(.custom("Roboto-Medium", size: 14))
                }
                .buttonStyle(GradientButtonStyle())
                .padding(.trailing, 10)
                .keyboardShortcut("d", modifiers: [.command])
            }
            
            Spacer()
            
            Button{
                // clear conversation
                appState.clearConversation()
                appState.promptText = ""
                appState.messages = []
                appState.isLoading = false
            } label: {
                Text("Clear conversation ⌘ + p")
                    .font(.custom("Roboto-Medium", size: 14))
            }
            .buttonStyle(GradientButtonStyle())
            .keyboardShortcut("p", modifiers: [.command])
        }
        .padding(.top, 10)
        .padding(.bottom, 10)
    }
}

struct ActionBarView_Previews: PreviewProvider {
    static var previews: some View {
        ActionBarView(contentVM: ContentViewModel(appState: AppState.shared))
            .environmentObject(AppState.shared)
    }
}
