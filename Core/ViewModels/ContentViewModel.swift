//
//  ContentViewModel.swift
//  Core
//
//  Created by Saqib Omer on 12/05/2023.
//

import SwiftUI
import Combine

public final class ContentViewModel: ObservableObject {

    @Published public var searchBar = ""
    @Published public var clipBoard = false
    @Published public var textEditor = ""
    
    
    public init() {
        
    }
}
