//
//  PromptView.swift
//  Core
//
//  Created by Nick Smet on 21/06/2023.
//
import SwiftUI
import CoreGraphics
import Core

struct PromptView: View {
    @EnvironmentObject var appState: AppState
    @ObservedObject var contentVM: ContentViewModel
    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack(alignment: .top) {
            PromptField
            if appState.isLoading {
                LoadingViewAnimation
                    .frame(width: CGFloat(45))
            }
            else {
                BtnView
                    .frame(width: CGFloat(45))
            }
        }
        .background(Color.textEditorBackgroundColor)
        .cornerRadius(5)
    }
    
    var PromptField: some View {
        ZStack(alignment: .topLeading) {
            if appState.promptText.isEmpty {
                Text("What would you like to do?")
                    .foregroundColor(Color.white)
                    .font(.custom("Roboto-Medium", size: 20))
                    .opacity(0.25)
                    .padding([.bottom, .trailing], 14.0)
                    .padding(.leading, 8.0)
                    .padding(.top, 3.0)
            }
            TextEditor(text: $appState.promptText)
                .foregroundColor(Color.white)
                .font(.custom("Roboto-Medium", size: 20))
                .lineSpacing(8)
                .padding(.horizontal, 10.0)
                .frame(height: CGFloat(WindowManager.shared.promptOnlyheight))
                .fixedSize(horizontal: false, vertical: true)
                .disableAutocorrection(true)
                .textFieldStyle(.plain)
                .focused($isFocused)
                .submitLabel(.done)
                
        }
        .padding(.all, 8)
        .cornerRadius(5)
    }

    var BtnView: some View {
        Button(action: {
            appState.isLoading = true
            contentVM.callApiChatGpt(inputText: appState.promptText)
            appState.promptText = ""
        }) {
            HStack {
                Image(appState.promptText.isEmpty ? "submit-disabled" : "submit-active")
            }
        }
        .padding([.top, .trailing], 12)
        .buttonStyle(.borderless)
        .disabled(appState.promptText.isEmpty)
        
        
    }
    
    var LoadingViewAnimation: some View {
        GIFImageView(imageName: "animation_300_lhabwwiy.gif" ,width: 100, height: 100)
            .frame(width: 50, height: 50)
            .offset(y: 0)
    }
}

struct PromptView_Previews: PreviewProvider {
    static var previews: some View {
        PromptView(contentVM: ContentViewModel(appState: AppState.shared))
        .environmentObject(AppState.shared)
    }
}
