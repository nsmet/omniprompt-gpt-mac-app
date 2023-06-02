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
    
    @Published var chatResponseStatus : ChatResponseStatus = .none
    @Published var chatResponse = ""
    @Published var alertMessage = ""
    @Published var showAlert = false
    var chatMessages: [Chat] = []
    var openAI: OpenAI!
    @StateObject var appState = AppState.shared
    
    public init() {
        chatMessages.append(Chat(role: .system, content: "You are a helpful assistant."))
    }
    public func callApiChatGpt(inputText: String) {
        self.showLoadingAnimation = true
        if let key = UserDefaults.standard.object(forKey: "apiKey") as? String, key != "" {
            self.openAI = OpenAI(apiToken: key)
        } else {
            showLoadingAnimation = false
            self.showErrorView = true
            return
        }
        chatMessages.append(Chat(role: .user, content: inputText))
        guard let model = UserDefaults.standard.object(forKey: "openAPIModel") as? String else { return }
        let query = ChatQuery(model: model, messages: chatMessages)
        self.openAI.chats(query: query) { result in
            DispatchQueue.main.async {
                self.showLoadingAnimation = false
            }
            
            
            switch result {
            case .success(let res):
                withAnimation(.easeInOut(duration: 0.5)) {
                    DispatchQueue.main.async {
                        if res.choices.count > 0 {
                            self.textEditor = res.choices.last!.message.content
                            self.chatMessages.append(Chat(role: .assistant, content: res.choices.last!.message.content))
                        } else {
                            self.showLoadingAnimation = true
                            self.showErrorView = true
                            self.reset()
                        }

                    }
                }
            case .failure(let err):
                print("Chat Erro: \(err)")
                DispatchQueue.main.async {
                    self.alertMessage = err.localizedDescription
                    self.showLoadingAnimation = false
                    self.showErrorView = true
                    self.reset()
                }
            }
        }
    }
    func reset() {
        self.chatMessages.removeAll()
        chatMessages.append(Chat(role: .system, content: "You are a helpful assistant."))
    }
}
