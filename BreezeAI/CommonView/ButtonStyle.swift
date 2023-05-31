//
//  ButtonStyle.swift
//  BreezeAI
//
//  Created by Saqib Omer on 31/05/2023.
//

import Foundation
import SwiftUI

struct GradientButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.inputText)
            .padding([.leading, .trailing], 16)
            .padding(.top, 2)
            .padding([.top, .bottom], 8)
            .background(Color.buttonColor)
//            .background(configuration.isPressed ? Color.inputText : Color.buttonColor)
            .cornerRadius(5)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}
