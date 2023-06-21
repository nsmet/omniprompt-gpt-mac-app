//
//  ContentView.swift
//  BreezeAI
//
//  Created by Saqib Omer on 12/05/2023.
//

import SwiftUI
import Core
import CoreGraphics


struct ContentView: View {
    @StateObject var contentVM: ContentViewModel
    @ObservedObject var appState = AppState.shared
    @State var height: CGFloat = 50
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .top) {
                    promptField
                    if contentVM.showLoadingAnimation {
                        loadingViewAnimation
                            .frame(width: CGFloat(45))
                    }
                    else {
                        btnView
                            .frame(width: CGFloat(45))
                    }
                }
                .background(Color.textEditorBackgroundColor)
                .cornerRadius(5)

                if !contentVM.textEditor.isEmpty {
                    textEditor
                        .background(RoundedRectangle(cornerRadius: 5)
                            .fill(Color.textEditorBackgroundColor)
                            .padding(.top, 8)
                        )
                        .cornerRadius(5)
                    bottomBar
                }
            }
            .padding(.all, 6)
            .background(Color.bgColor.opacity(0.98).blur(radius: 1))
            .cornerRadius(5)
            .preferredColorScheme(.dark)
            
            if contentVM.showErrorView {
                errorView
                    .frame(width: 752, height: CGFloat(WindowManager.shared.promptAndResponsHeight))
                    .background(Color.black)
                    .cornerRadius(5)
                    .offset(y: -100)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(contentVM: ContentViewModel())
    }
}

extension ContentView {
    var promptField: some View {
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

    var btnView: some View {
        Button(action: {
            contentVM.callApiChatGpt(inputText: appState.promptText)
            
        }) {
            HStack {
                Image(appState.promptText.isEmpty ? "submit-disabled" : "submit-active")
            }
        }
        .padding([.top, .trailing], 12)
        .buttonStyle(.borderless)
        .disabled(appState.promptText.isEmpty)
        
        
    }
    
    var loadingViewAnimation: some View {
        ActivityIndicator()
        .frame(width: 25, height: 25)
        .padding(.trailing, 10)
        .foregroundColor(.blue)
        .offset(y: 10)
    }
    
    var bottomBar: some View {
        HStack(spacing: 10){
            Spacer()
            //            Button{
            //                withAnimation(.easeIn) {
            ////                    appState.promptText =  AppState.shared.copiedText
            //                    let pasteboard = NSPasteboard.general
            //                    pasteboard.declareTypes([.string], owner: nil)
            //                    pasteboard.setString("", forType: .string)
            //
            //                }
            //                NSApplication.shared.hide(nil)
            //            } label: {
            //                Text("Replace selected text")
            //                    .font(.custom("Roboto-Medium", size: 14))
            //            }
            //            .buttonStyle(GradientButtonStyle())
            //            .cornerRadius(5)
            //            .padding(.bottom, 10)
            ////            .opacity(AppState.shared.copiedText == "" ? 0 : 1)
            //            .opacity(contentVM.textEditor == "" ? 0 : 1)
            
            Button{
                let pasteboard = NSPasteboard.general
                pasteboard.clearContents()
                pasteboard.setString(contentVM.textEditor, forType: .string)
                NSApplication.shared.hide(nil)
            } label: {
                Text("Copy to clipboard")
                    .font(.custom("Roboto-Medium", size: 14))
            }
            .buttonStyle(GradientButtonStyle())
            .padding(.trailing, 10)
        }
        .padding(.top, 10)
        .padding(.bottom, 10)
    }
    var textEditor: some View {
        TextEditor(text: $contentVM.textEditor)
            .foregroundColor(Color.inputText)
            .font(.custom("Inter-Regular", size: 14))
            .lineSpacing(8)
            .padding(/*@START_MENU_TOKEN@*/.all, 14.0/*@END_MENU_TOKEN@*/)
            .frame(maxWidth: .infinity, minHeight: 250, maxHeight: 250, alignment: .leading)
            .fixedSize(horizontal: false, vertical: true)
            .disableAutocorrection(true)
            .textFieldStyle(.plain)
            .onAppear {
                if let window = NSApp.windows.first {
                    //hide title and bar
                    window.titleVisibility = .hidden
                    window.titlebarAppearsTransparent = true
                    window.backgroundColor = .clear
                    window.hasShadow = false
                    window.isOpaque = false
                    WindowManager.shared.setWindowFrame(resultVisible: true)
                }
            }
    }
    
    var errorView: some View {
        VStack {
            Text("Oh snap!")
                .foregroundColor(.white)
                .font(.custom("Roboto-Bold", size: 28))
            Text("Something went wrong....")
                .foregroundColor(.white)
                .font(.custom("Roboto-Bold", size: 28))
            Text("Please make sure you provided us with a valid OpenAI API key")
                .foregroundColor(.white)
                .font(.custom("Roboto-Bold", size: 16))
                .padding(.top, 20)
            Button{
                contentVM.showErrorView = false
                if let window = NSApp.windows.first {
                    
                    //hide title and bar
                    window.titleVisibility = .hidden
                    window.titlebarAppearsTransparent = true
    //                window.backgroundColor = .clear
                    window.hasShadow = false
                    window.isOpaque = false
                }
            } label: {
                Text("Ok, I'll check")
                    .font(.custom("Roboto-Medium", size: 12))
            }
            .buttonStyle(GradientButtonStyle())
            .cornerRadius(5)
            .padding(.trailing, 15)
            .padding(.bottom, 10)
        }
    }
}

