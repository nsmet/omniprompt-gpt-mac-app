//
//  BackgroundView.swift
//  BreezeAI
//
//  Created by Saqib Omer on 12/05/2023.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
//        ZStack {
            RoundedRectangle(cornerRadius: 1)
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
