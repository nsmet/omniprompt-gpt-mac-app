//
//  MessagesView.swift
//  Core
//
//  Created by Nick Smet on 21/06/2023.
//

import SwiftUI
import Core

struct MessagesView: View {
    @EnvironmentObject var appState: AppState
    @ObservedObject var contentVM: ContentViewModel
    
    @State var stackHeight : CGFloat = 350
    
    
    var body: some View {
        ScrollView(.vertical) {
            ScrollViewReader { scrollProxy in
                VStack(spacing: 0) {
                    ForEach(appState.messages.indices, id: \.self) { index in
                        Text(appState.messages[index].message)
                            .foregroundColor(Color.inputText)
                            .font(.custom("Inter-Regular", size: 16))
                            .lineSpacing(8)
                            .padding(.all, 14.0)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .multilineTextAlignment(.leading)
                            .textSelection(.enabled)
                            .background(appState.messages[index].isUser ? Color.userMessageBgColor : Color.botMessageBgColor)
                            .id(appState.messages[index].id)
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: Alignment.topLeading)
                .onChange(of: appState.messages.count) { value in
                    withAnimation {
                        scrollProxy.scrollTo(value - 1, anchor: .bottom)
                    }
                    
                }
                .onAppear() {
                    if appState.messages.count > 0 {
                        scrollProxy.scrollTo(appState.messages[appState.messages.count - 1].id)
                    }
                }
            }
        }
        .frame(width: 752, height: 350)
        .cornerRadius(5)
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView(contentVM: ContentViewModel(appState: AppState.shared))
            .environmentObject(AppState.shared)
    }
}
