//
//  ContentViewModel.swift
//  Core
//
//  Created by Saqib Omer on 12/05/2023.
//

import SwiftUI
import Combine
import OpenAI

public final class ContentViewModel: ObservableObject {
    @Published public var clipBoard = false
    @Published public var textEditor = ""
    @Published public var showLoadingAnimation = false
    @Published public var showErrorView = false
    @Published public var isUserAtBottom = false
    
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
        if let key = UserDefaults.standard.object(forKey: "apiKey") as? String, key != "" {
            self.openAI = OpenAI(apiToken: key)
        } else {
            self.showErrorView = true
            return
        }
        // build the conversation
        var chatMessages: [Chat] = []
        chatMessages.append(Chat(role: .system, content: "You are a helpful assistant."))
        
        for message in appState.messages {
            chatMessages.append(Chat(role: message.isUser ? .user : .assistant, content: message.message))
        }
        
        guard let model = UserDefaults.standard.object(forKey: "openAPIModel") as? String else { return }
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
                            self.textEditor = res.choices.last!.message.content
                            self.appState.addMessage(isUser: false, message: res.choices.last!.message.content)
                        } else {
                            self.showErrorView = true
                            self.reset()
                        }

                    }
                }
            case .failure(let err):
                print("Chat Erro: \(err)")
                DispatchQueue.main.async {
                    self.alertMessage = err.localizedDescription
                    self.showErrorView = true
                    self.reset()
                }
            }
        }
    }
    func reset() {
    }
}
