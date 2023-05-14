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
}

public final class AppState: ObservableObject {
  
  @Published public var router: AppRouting = .contentView
  @Published public var isConnectedToInternet: Bool = false
    
  public init () {
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
