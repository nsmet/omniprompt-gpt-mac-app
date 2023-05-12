//
//  SettingViewModel.swift
//  Core
//
//  Created by Saqib Omer on 12/05/2023.
//

import SwiftUI
import Combine

public final class SettingViewModel: ObservableObject {

    @Published public var apiKeyTF = ""
    @Published public var openAPIModel = ["gpt-4", "gpt-4-32k", "gpt-3.5-turbo"]
    
    
    public init() {
        
    }
}
