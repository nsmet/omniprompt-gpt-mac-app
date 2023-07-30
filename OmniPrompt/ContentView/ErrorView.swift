//
//  ErrorView.swift
//  OmniPrompt
//
//  Created by Nick Smet on 22/06/2023.
//

import SwiftUI
import Core

struct ErrorView: View {
    @EnvironmentObject var appState: AppState
    @ObservedObject var contentVM: ContentViewModel
    
    var body: some View {
        VStack {
            Text("Oh snap!")
                .foregroundColor(.white)
                .font(.custom("Roboto-Bold", size: 28))
            Text("Something went wrong....")
                .foregroundColor(.white)
                .font(.custom("Roboto-Bold", size: 20))
                .padding(.top, 4)
            
            Image("sad-bot")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 75)
                .padding([.top, .bottom], 16)
            
            Text("Please make sure you provided us with a valid OpenAI API key")
                .foregroundColor(.white)
                .font(.custom("Roboto-Bold", size: 16))
                .padding(.top, 20)
            Button{
                appState.showErrorView = false
                if let window = NSApp.windows.first {
                    //hide title and bar
                    window.titleVisibility = .hidden
                    window.titlebarAppearsTransparent = true
                    window.hasShadow = false
                    window.isOpaque = false
                }
            } label: {
                Text("Close")
                    .font(.custom("Roboto-Medium", size: 14))
            }
            .buttonStyle(GradientButtonStyle())
            .cornerRadius(5)
            .padding(.top, 16)
        }
        .background(Color.bgColor.opacity(0.98).blur(radius: 0.8))
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(contentVM: ContentViewModel(appState: AppState.shared))
            .environmentObject(AppState.shared)
    }
}
