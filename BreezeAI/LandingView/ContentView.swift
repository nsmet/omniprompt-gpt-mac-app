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
        HStack {
            TextField("What would you like to do?", text: $contentVM.searchBar)
            Image(systemName: "mic")
        }
    }

    var copyToClipBoardBtn: some View {
        HStack{
            Spacer()
            Button{
                
            } label: {
                Text("Copy to clipboard")
                    .padding(5)
            }
            .padding(.trailing, 20)
            .padding(.bottom, 10)
            
        }
    }
}
