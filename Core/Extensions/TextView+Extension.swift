//
//  TextView+Extension.swift
//  Core
//
//  Created by Saqib Omer on 12/05/2023.
//

import Foundation
import AppKit
import SwiftUI

extension NSTextView {
  open override var frame: CGRect {
    didSet {
      backgroundColor = .clear
      drawsBackground = true
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
