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
}
