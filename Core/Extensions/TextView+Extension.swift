//
//  TextView+Extension.swift
//  Core
//
//  Created by Nick Smet on 12/05/2023.
//

import Foundation
import AppKit
import SwiftUI

extension NSTextView {
  open override var frame: CGRect {
    didSet {
      backgroundColor = .clear
      drawsBackground = true
//        textContainerInset = NSSize(width: 0, height: 5)
//        textContainer?.lineFragmentPadding = 5
    }
  }
}
extension View {
   public func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .topLeading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
