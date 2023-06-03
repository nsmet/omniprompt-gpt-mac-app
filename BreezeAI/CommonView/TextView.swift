//
//  TextView.swift
//  BreezeAI
//
//  Created by Saqib Omer on 03/06/2023.
//

import Foundation
import SwiftUI


struct TextView: View {
    @Binding var text: String
    var placeholder: String
    var backgroundColor: Color
    var onCommit: () -> Void
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color.placeholder)
                    .padding(EdgeInsets(top: 8, leading: 10, bottom: 0, trailing: 0))
            }
            TextEditor(text: $text)
                .fixedSize(horizontal: false, vertical: true)
                .foregroundColor(Color.inputText)
                .disableAutocorrection(true)
                .padding(4)
                .padding(.top, 4)
                .onReceive(NotificationCenter.default.publisher(for: NSTextView.didChangeNotification)) { _ in
                    handleTextChange()
                }
        }
        .font(.custom("Roboto-Medium", size: 20))
    }
    
    private func handleTextChange() {
        let lines = text.components(separatedBy: .newlines)
        if let lastLine = lines.last, lastLine.hasSuffix("\n") {
            text = text + "\n" // Append a newline character to preserve the last line
        }
        if text.last == "\n" {
            onCommit() // Call the onCommit function when the enter key is pressed
        }
    }
}
