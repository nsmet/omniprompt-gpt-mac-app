//
//  AppState.swift
//  Core
//
//  Created by Nick Smet on 14/05/2023.
//

import Foundation
import Combine
import SwiftUI
import Network
import ServiceManagement

public enum AppRouting: String {
    case contentView // Show ContentView
    case settingsView // Show SettingsView
    case done
    case none
}

public final class AppState: ObservableObject {
    public static let shared = AppState()
    @Published public var router: AppRouting = .none
    @Published public var isConnectedToInternet: Bool = false
    @Published public var promptText: String = ""
    @Published public var originalSelectedText: String = ""
    @Published public var isLoading: Bool = false;
    @Published public var messages: [Message] = []
    @Published public var showErrorView: Bool = false
    
    // settings
    public var openAPIModels = ["gpt-4", "gpt-4-32k", "gpt-3.5-turbo"]
    
    @Published public var openAIApiKey: String {
        didSet {
          UserDefaults.standard.set(openAIApiKey, forKey: "openAIApiKey")
      }
    }

    @Published public var openAIPromptModel: String {
      didSet {
          UserDefaults.standard.set(openAIPromptModel, forKey: "openAIPromptModel")
      }
    }
    
    
    public init () {
        self.openAIApiKey = UserDefaults.standard.string(forKey: "openAIApiKey") ?? ""
        self.openAIPromptModel = UserDefaults.standard.string(forKey: "openAIPromptModel") ?? "gpt-3.5-turbo"

        if let savedMessages = UserDefaults.standard.object(forKey: "messages") as? Data {
           let decoder = JSONDecoder()
           if let loadedMessages = try? decoder.decode([Message].self, from: savedMessages) {
               self.messages = loadedMessages
           }
        }
        
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    self.isConnectedToInternet = true
                    
                }
            } else {
                DispatchQueue.main.async {
                    self.isConnectedToInternet = false
                    
                }
            }
        }
        let queue = DispatchQueue(label: "MyCardsNetworkMonitor")
        monitor.start(queue: queue)
    }
    
    public func addMessage(isUser: Bool, message: String) {
        let newMessage = Message(message: message, isUser: isUser, date: Date())
        self.messages.append(newMessage)

        // Save messages to UserDefaults
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(self.messages) {
           UserDefaults.standard.set(encoded, forKey: "messages")
        }
   }
    
    public func clearConversation() {
        // Save messages to UserDefaults
        UserDefaults.standard.removeObject(forKey: "messages")
        WindowManager.shared.setWindowFrame(small: true)
   }
}

