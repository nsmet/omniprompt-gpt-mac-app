//
//  Window+Extensions.swift
//  Core
//
//  Created by TOxIC on 14/05/2023.
//

import SwiftUI

extension NSWindow {

   enum Style {
      case main
   }

   convenience init(contentRect: CGRect, style: Style) {
      switch style {
      case .main:
         let styleMask: NSWindow.StyleMask = [.closable, .titled, .fullSizeContentView]
         self.init(contentRect: contentRect, styleMask: styleMask, backing: .buffered, defer: true)
         titlebarAppearsTransparent = true
         titleVisibility = .hidden
         standardWindowButton(.zoomButton)?.isHidden = true
         standardWindowButton(.miniaturizeButton)?.isHidden = true
      }
   }
}
