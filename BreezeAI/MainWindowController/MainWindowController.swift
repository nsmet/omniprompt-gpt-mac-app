////
////  MainWindowController.swift
////  BreezeAI
////
////  Created by TOxIC on 14/05/2023.
////
//
//import SwiftUI
//import Core
//
//class WelcomeWindowController: NSWindowController {
//
//   private (set) lazy var viewController = WelcomeViewController()
//   private let contentWindow: NSWindow
//
//   init() {
//      contentWindow = NSWindow(contentRect: CGRect(x: 400, y: 200, width: 800, height: 472), style: .main)
//      super.init(window: contentWindow)
//
//      let frameSize = contentWindow.contentRect(forFrameRect: contentWindow.frame).size
//      viewController.view.setFrameSize(frameSize)
//      contentWindow.contentViewController = viewController
//   }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//class WelcomeViewController: NSViewController {
//
//   private lazy var contentView = View()
//
//   override func loadView() {
//      view = contentView
//   }
//
//   init() {
//      super.init(nibName: nil, bundle: nil)
//   }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//   override func viewDidLoad() {
//      super.viewDidLoad()
//      contentView.backgroundColor = .white
//   }
//}
//
//class View: NSView {
//
//   var backgroundColor: NSColor?
//
//   convenience init() {
//      self.init(frame: NSRect())
//   }
//
//   override func draw(_ dirtyRect: NSRect) {
//      if let backgroundColor = backgroundColor {
//         backgroundColor.setFill()
//         dirtyRect.fill()
//      } else {
//         super.draw(dirtyRect)
//      }
//   }
//}
