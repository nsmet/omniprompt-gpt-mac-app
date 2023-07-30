//
//  BackgroundView.swift
//  OmniPrompt
//
//  Created by Nick Smet on 12/05/2023.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
//        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .background(Color.bgColor)
//        }
//        .padding(.top, -50)
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
