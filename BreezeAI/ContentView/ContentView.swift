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
    
    var body: some View {
        //        ZStack {
        //            VStack{
        //                HStack(alignment: .top){
        //                    textField
        //                    if appState.selectedText != "" {
        //                        btnView
        //                    }
        //                }
        //                Divider()
        //                    .foregroundColor(.gray)
        //                textEditor
        ////                Spacer()
        //                Divider()
        //                    .foregroundColor(.gray)
        //                bottomBar
        //
        //            }
        ////            if contentVM.showLoadingAnimation {
        ////                loadingView
        ////                    .frame(maxWidth: .infinity, maxHeight: .infinity)
        ////                    .background(Color.black).opacity(0.8)
        ////            }
        //            if contentVM.showErrorView {
        //                errorView
        //                    .frame(maxWidth: .infinity, maxHeight: .infinity)
        //                    .background(Color.black).opacity(0.8)
        //
        //            }
        //
        //        }
        
        
        VStack{
            textField
        }
        .overlay(
            VStack(alignment:.trailing) {
                
                HStack(alignment: .top) {
                    Spacer()
                    if contentVM.showLoadingAnimation {
                        loadingViewAnimation
                    } else {
                        btnView
                    }
                    
                }
                .padding(.top, 5)
                Spacer()
            }
        )
        .ignoresSafeArea()
        .background(Color.bgColor)
        .cornerRadius(5)
        
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(contentVM: ContentViewModel())
    }
}

extension ContentView {
    
    var textField: some View {
        
        Text(appState.selectedText.isEmpty ? "What would you like to do?" : appState.selectedText)
            .padding([.leading, .top, .bottom], 20)
            .foregroundColor(Color.placeholder)
            .font(.custom("Roboto-Medium", size: 20))
            .opacity(appState.selectedText.isEmpty ? 1 : 0)
            .frame(maxWidth: .infinity, minHeight: 40, alignment: .leading)
            .overlay(
                TextEditor(text: $appState.selectedText)
                    .foregroundColor(Color.inputText)
                    .font(.custom("Roboto-Medium", size: 20))
                    .disableAutocorrection(true)
                    .padding([.top, .bottom], 20)
                    .padding(.leading, 14)
                    .textFieldStyle(.plain)
                
            )
        
    }
    
    var placeholder:some View {
        Text("What would you like to do?")
            .foregroundColor(.white)
            .font(.custom("Roboto-Medium", size: 18))
    }
    var btnView: some View {
        
        Button(action: {
            contentVM.showLoadingAnimation = true
        }) {
            HStack {
                Image("enterBtn")
            }
        }
        .padding([.top, .trailing], 12)
        .buttonStyle(.borderless)
        
    }
    
    var loadingViewAnimation: some View {
        GIFImageView(imageName: "animation_300_lhabwwiy.gif" ,width: 100, height: 100)
            .padding(.trailing, -25)
            .frame(maxHeight: 100)
            .offset(y: 0)
    }
    
    var bottomBar: some View {
        HStack(spacing: 10){
            Spacer()
            //            Button{
            //                withAnimation(.easeIn) {
            ////                    appState.selectedText =  AppState.shared.copiedText
            //                    let pasteboard = NSPasteboard.general
            //                    pasteboard.declareTypes([.string], owner: nil)
            //                    pasteboard.setString("", forType: .string)
            //
            //                }
            //                NSApplication.shared.hide(nil)
            //            } label: {
            //                Text("Replace selected text")
            //                    .font(.custom("Roboto-Medium", size: 12))
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

