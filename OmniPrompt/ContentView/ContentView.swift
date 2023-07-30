//
//  ContentView.swift
//  OmniPrompt
//
//  Created by Nick Smet on 12/05/2023.
//

import SwiftUI
import Core
import CoreGraphics


struct ContentView: View {
    @ObservedObject var contentVM: ContentViewModel
    @EnvironmentObject var appState: AppState
    @State var height: CGFloat = 50
    
    var body: some View {
        ZStack {
            if !appState.showErrorView {
                VStack(alignment: .leading, spacing: 0) {
                    if appState.messages.count > 0 {
                        MessagesView(contentVM: contentVM)
                            .padding(.bottom, 8)
                    }
                    
                    PromptView(contentVM: contentVM)
                    ActionBarView(contentVM: contentVM)
                }
                .padding(.all, 6)
                .preferredColorScheme(.dark)
            }
            
            
            if appState.showErrorView {
                ErrorView(contentVM: contentVM)
                    .frame(width: 752, height: 400)
                    .cornerRadius(5)
                    .preferredColorScheme(.dark)
            }
        }
        .environmentObject(AppState.shared)
        .background(Color.bgColor.opacity(0.98).blur(radius: 0.8))
        .cornerRadius(5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(contentVM: ContentViewModel(appState: AppState.shared))
            .environmentObject(AppState.shared)
    }
}
