//
//  AppState.swift
//  Core
//
//  Created by Saqib Omer on 14/05/2023.
//

import Foundation
import Combine
import SwiftUI
import Network

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
    @Published public var selectedText: String = "Hi what is your name?"
    @Published public var shouldPerformCommand: Bool = false
    @Published public var copiedText = ""
    
    @Published public var apiKeyTF: String {
        didSet {
            UserDefaults.standard.set(apiKeyTF, forKey: "apiKey")
        }
    }
    public var openAPIModels = ["gpt-4", "gpt-4-32k", "gpt-3.5-turbo"]
    @Published public var openAPIModel: String {
        didSet {
            UserDefaults.standard.set(openAPIModel, forKey: "openAPIModel")
        }
    }
    
    public init () {
        self.apiKeyTF = UserDefaults.standard.object(forKey: "apiKey") as? String ?? ""
        self.openAPIModel = UserDefaults.standard.object(forKey: "openAPIModel") as? String ?? "gpt-3.5-turbo"
        
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
}
