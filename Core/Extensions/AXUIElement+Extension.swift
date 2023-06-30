//
//  AXUIElement+Extension.swift
//  Core
//
//  Created by Nick Smet on 18/05/2023.
//

import Foundation
import SwiftUI
import ApplicationServices
import Cocoa

extension AXUIElement {
    public static var focusedElement: AXUIElement? {
        systemWide.element(for: kAXFocusedUIElementAttribute)
    }
    
      public var selectedText: String? {
        rawValue(for: kAXSelectedTextAttribute) as? String
      }
    
    public static var systemWide = AXUIElementCreateSystemWide()
    
    public func element(for attribute: String) -> AXUIElement? {
        guard let rawValue = rawValue(for: attribute), CFGetTypeID(rawValue) == AXUIElementGetTypeID() else { return nil }
        return (rawValue as! AXUIElement)
    }
    func rawValue(for attribute: String) -> AnyObject? {
        var rawValue: AnyObject?
        let error = AXUIElementCopyAttributeValue(self, attribute as CFString, &rawValue)
        return error == .success ? rawValue : nil
    }
}
