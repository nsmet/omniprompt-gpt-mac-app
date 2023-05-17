//
//  ContentView.swift
//  BreezeAI
//
//  Created by Saqib Omer on 12/05/2023.
//

import SwiftUI
import Core

struct ContentView: View {
    
    @ObservedObject var contentVM: ContentViewModel
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack{
                textField
                Divider()
                    .foregroundColor(.gray)
                textEditor
                Spacer()
                Divider()
                    .foregroundColor(.gray)
                copyToClipBoardBtn
            }
            if contentVM.showLoadingAnimation {
                errorView
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black).opacity(0.8)
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
    
    var textField: some View {
        HStack(spacing: 0) {
            TextField("", text: $contentVM.searchBar)
                .font(.custom("Roboto-Medium", size: 20))
                .placeholder(when: contentVM.searchBar.isEmpty) {
                    Text("What would you like to do?").foregroundColor(Color.placeholder)
                        .font(.custom("Roboto-Medium", size: 20))
                }
                .textFieldStyle(PlainTextFieldStyle())
                .foregroundColor(Color.inputText)
                .padding(.leading, 16)
            Image("enterBtn")
                .padding(.trailing, 16)
        }
    }
    
    var copyToClipBoardBtn: some View {
        HStack(spacing: 1){
            Spacer()
            Button{
                withAnimation(.easeIn) {
                    contentVM.showLoadingAnimation.toggle()
                    let pasteboard = NSPasteboard.general
                    pasteboard.declareTypes([.string], owner: nil)
                    pasteboard.setString("Recipe text from Instgram", forType: .string)
                    Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
                        withAnimation(.easeInOut(duration: 3)) {
                            self.contentVM.showLoadingAnimation.toggle()
                        }
                    }
                }
            } label: {
                Text("Replace selected text")
                    .font(.custom("Roboto-Medium", size: 12))
                    .padding(5)
                    .background(Color.buttonColor)
                    .foregroundColor(Color.white)
            }
            .buttonStyle(.borderless)
            .cornerRadius(5)
            .padding(.trailing, 15)
            .padding(.bottom, 10)
            
            Button{
                let pasteboard = NSPasteboard.general
                pasteboard.clearContents()
                pasteboard.setString(contentVM.textEditor, forType: .string)
            } label: {
                Text("Copy to clipboard")
                    .font(.custom("Roboto-Medium", size: 12))
                    .padding(5)
                    .background(Color.buttonColor)
                    .foregroundColor(Color.white)
            }
            .buttonStyle(.borderless)
            .cornerRadius(5)
            .padding(.trailing, 15)
            .padding(.bottom, 10)
            
            
        }
    }
    var textEditor: some View {
        VStack{
            TextEditor(text: $contentVM.textEditor)
                .font(.custom("Inter-Regular", size: 14))
                .placeholder(when: contentVM.textEditor.isEmpty) {
                    Text("Paste text, start typing or let us generate text").foregroundColor(Color.placeholder)
                        .font(.custom("Inter-Regular", size: 14))
                }
                .padding(.leading, 5)
                .padding(.top, 10)
                .background(Color.textEditorBackgroundColor)
                .foregroundColor(Color.inputText)
        }
        .padding([.leading, .trailing], 10)
    }
    
    var loadingView: some View {
        VStack(alignment: .center) {
            QLImage("animation_300_lhabwwiy")
            .frame(width: 100, height: 150, alignment: .center)
            Text("Loading some AI magic...")
                .foregroundColor(.white)
                .font(.custom("Roboto-Bold", size: 14))
            
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
                
            } label: {
                Text("Ok, I'll check")
                    .font(.custom("Roboto-Medium", size: 12))
                    .padding(5)
                    .background(Color.buttonColor)
                    .foregroundColor(Color.white)
            }
            .buttonStyle(.borderless)
            .cornerRadius(5)
            .padding(.trailing, 15)
            .padding(.bottom, 10)
        }
    }
}
