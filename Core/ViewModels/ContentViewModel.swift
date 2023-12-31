//
//  ContentViewModel.swift
//  Core
//
//  Created by Nick Smet on 12/05/2023.
//

import SwiftUI
import Combine
import OpenAI

public final class ContentViewModel: ObservableObject {
    @Published var chatResponseStatus : ChatResponseStatus = .none
    @Published var chatResponse = ""
    @Published var alertMessage = ""
    @Published var showAlert = false
    
    var openAI: OpenAI!
    var appState: AppState
    
    public init(appState: AppState) {
        self.appState = appState
    }
    
    public func callApiChatGpt(inputText: String) {
        appState.addMessage(isUser: true, message: inputText)
        // init the loading state
        
        
        guard !NSEvent.modifierFlags.contains(.shift) else {
            return
        }
        if !self.appState.openAIApiKey.isEmpty {
            self.openAI = OpenAI(apiToken: self.appState.openAIApiKey)
        } else {
            self.appState.showErrorView = true
            return
        }
        // build the conversation
        var chatMessages: [Chat] = []
        chatMessages.append(Chat(role: .system, content: "Your name is OmniPrompt. You are a helpful assistant"))
        
        for message in appState.messages {
            chatMessages.append(Chat(role: message.isUser ? .user : .assistant, content: message.message))
        }
        
        let model = self.appState.openAIPromptModel
        let query = ChatQuery(model: model, messages: chatMessages)
        
        self.openAI.chats(query: query) { result in
            DispatchQueue.main.async {
                self.appState.isLoading = false
            }
            
            switch result {
            case .success(let res):
                withAnimation(.easeInOut(duration: 0.5)) {
                    DispatchQueue.main.async {
                        if res.choices.count > 0 {
                            self.appState.showErrorView = false
                            self.appState.addMessage(isUser: false, message: res.choices.last!.message.content)
                        } else {
                            self.appState.showErrorView = true
                            self.reset()
                        }

                    }
                }
            case .failure(let err):
                print("Chat Erro: \(err)")
                DispatchQueue.main.async {
                    self.alertMessage = err.localizedDescription
                    self.appState.showErrorView = true
                    self.reset()
                }
            }
        }
    }
    
    func reset() {
    }
}
