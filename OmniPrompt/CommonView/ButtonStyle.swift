//
//  ButtonStyle.swift
//  OmniPrompt
//
//  Created by Nick Smet on 31/05/2023.
//

import Foundation
import SwiftUI

struct GradientButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
            .padding([.leading, .trailing], 16)
            .padding(.top, 2)
            .padding([.top, .bottom], 8)
            .background(Color.darkBg)
            .cornerRadius(5)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}
