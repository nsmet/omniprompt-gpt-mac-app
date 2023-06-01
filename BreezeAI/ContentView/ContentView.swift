//
//  ContentView.swift
//  BreezeAI
//
//  Created by Saqib Omer on 12/05/2023.
//

import SwiftUI
import Core
import CoreGraphics

extension CGKeyCode
{
    // Define whatever key codes you want to detect here
    static let kVK_UpArrow: CGKeyCode = 0x24

    var isPressed: Bool {
        CGEventSource.keyState(.combinedSessionState, key: self)
    }
}

struct ContentView: View {
    
    @StateObject var contentVM: ContentViewModel
    @ObservedObject var appState = AppState.shared
    
    
    var body: some View {
        ZStack {
            VStack{
                HStack(spacing: 0){
                    textField
                    if appState.selectedText != "" {
                        btnView
                    }
                }
                Divider()
                    .foregroundColor(.gray)
                textEditor
//                Spacer()
                Divider()
                    .foregroundColor(.gray)
                bottomBar
                
            }
            if contentVM.showLoadingAnimation {
                loadingView
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black).opacity(0.8)
            }
            if contentVM.showErrorView {
                errorView
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black).opacity(0.8)
                
            }
            
        }
        .background(Color.backgroundColor)
//        .onAppear {
//            if let pastBoard = NSPasteboard.general.string(forType: .string) {
//                contentVM.copiedText = pastBoard
//            }
//        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(contentVM: ContentViewModel())
    }
}

extension ContentView {
    
    var textField: some View {
        ZStack{
            HStack{
                Text("What would you like to do?")
                    .font(.custom("Roboto-Medium", size: 20))
                    .foregroundColor(Color.placeholder)
                    .opacity(appState.selectedText == "" ? 1 : 0)
                    .padding(.leading, 16)
                    .padding(.bottom, 10)
                Spacer()
            }
            TextField("", text: $appState.selectedText, axis: .vertical)
                .font(.custom("Roboto-Medium", size: 20))
            //            .placeholder(when: appState.selectedText.isEmpty) {
            //                Text("What would you like to do?").foregroundColor(Color.placeholder)
            //                    .font(.custom("Roboto-Medium", size: 20))
            //            }
                .textFieldStyle(PlainTextFieldStyle())
                .foregroundColor(Color.inputText)
                .padding(.leading, 16)
                .padding(.bottom, 10)
                .onSubmit {
                    if CGKeyCode.kVK_UpArrow.isPressed {
                        // Do something in response to the key press.
                        contentVM.callApiChatGpt(inputText: appState.selectedText)
                    }
                    
                }
//                .keyboardShortcut(.defaultAction)
            
        }
        
        
        
    }
    var btnView: some View {
        Image("enterBtn")
            .padding(.trailing, 16)
            .padding(.top, 20)
            .onTapGesture {
                contentVM.callApiChatGpt(inputText: appState.selectedText)
            }
    }
    
    var bottomBar: some View {
        HStack(spacing: 10){
            Spacer()
            Button{
                withAnimation(.easeIn) {
//                    appState.selectedText =  AppState.shared.copiedText
                    let pasteboard = NSPasteboard.general
                    pasteboard.declareTypes([.string], owner: nil)
                    pasteboard.setString("", forType: .string)
                
                }
                NSApplication.shared.hide(nil)
            } label: {
                Text("Replace selected text")
                    .font(.custom("Roboto-Medium", size: 12))
            }
            .buttonStyle(GradientButtonStyle())
            .cornerRadius(5)
            .padding(.bottom, 10)
//            .opacity(AppState.shared.copiedText == "" ? 0 : 1)
            .opacity(contentVM.textEditor == "" ? 0 : 1)
            
            Button{
                let pasteboard = NSPasteboard.general
                pasteboard.clearContents()
                pasteboard.setString(contentVM.textEditor, forType: .string)
                NSApplication.shared.hide(nil)
            } label: {
                Text("Copy to clipboard")
                    .font(.custom("Roboto-Medium", size: 12))
            }
            .buttonStyle(GradientButtonStyle())
            .padding(.trailing, 15)
            .padding(.bottom, 10)
            .opacity(contentVM.textEditor == "" ? 0 : 1)
            
            
        }
    }
    var textEditor: some View {
        VStack{
            TextEditor(text: $contentVM.textEditor)
                .font(.custom("Roboto-Medium", size: 14))
//                .placeholder(when: contentVM.textEditor.isEmpty) {
//                    Text("Paste text, start typing or let us generate text").foregroundColor(Color.placeholder)
//                        .font(.custom("Roboto-Medium", size: 14))
//                        .padding(.leading, 5)
//                }
                .padding([.leading, .trailing], 13)
                .padding([.top, .bottom], 13)
                .background(Color.textEditorBackgroundColor)
                .foregroundColor(Color.inputText)
        }
        .padding([.leading, .trailing], 10)
        .padding([.top, .bottom], 5)
    }
    
    var loadingView: some View {
        VStack(spacing: -50) {
            QLImage("animation_300_lhabwwiy")
                .frame(width: 200, height: 200, alignment: .center)
            Text("Loading some AI magic...")
                .foregroundColor(.white)
                .font(.custom("Roboto-Bold", size: 14))
                .padding(.bottom, 100)
            
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
