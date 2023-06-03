//
//  PromptTextFieldStyle.swift
//  BreezeAI
//
//  Created by TOxIC on 04/06/2023.
//

import SwiftUI
struct PromptTextFieldStyle: TextFieldStyle {
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        VStack() {
            configuration
                .colorMultiply(.clear)
                .foregroundColor(.clear)

            Rectangle()
                .frame(height: 1, alignment: .bottom)
                .foregroundColor(.clear)
        }
    }
}

public struct PromptTextField: ViewModifier {
    var showPlaceHolder: Bool
    var placeholder: String

    public func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if showPlaceHolder {
                Text(placeholder)
                    .font(.custom("Roboto-Medium", size: 18))
                    .foregroundColor(.placeholder)
                    .padding(.leading, 16.0)
            }
            content
        }
    }
}
