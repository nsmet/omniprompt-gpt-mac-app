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
                .placeholder(when: contentVM.searchBar.isEmpty) {
                    Text("What would you like to do?").foregroundColor(Color.placeholder)
            }
            .frame(height: 55)
            .textFieldStyle(PlainTextFieldStyle())
            .padding([.horizontal], 10)
            Image(systemName: "arrow.uturn.left")
                .padding(.vertical, 20.5)
                .padding(.trailing, 10)
                .foregroundColor(.gray)
        }
    }

    var copyToClipBoardBtn: some View {
        HStack{
            Spacer()
            Button{
                
            } label: {
                Text("Copy to clipboard")
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
        TextEditor(text: $contentVM.textEditor)
            .placeholder(when: contentVM.textEditor.isEmpty) {
                Text("Paste text, start typing or let us generate text").foregroundColor(Color.placeholder)
            }
        .padding([.leading, .top], 10)
        .background(Color.black)
    }
}
