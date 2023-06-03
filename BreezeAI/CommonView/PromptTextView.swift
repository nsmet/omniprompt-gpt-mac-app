////
////  PromptTextView.swift
////  BreezeAI
////
////  Created by TOxIC on 04/06/2023.
////
//
//import SwiftUI
//
//struct PromptTextView: NSViewRepresentable {
//
//    @Binding var text: String?
//    @Binding var attributedText: NSAttributedString?
//    @Binding var desiredHeight: CGFloat
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    func makeUIView(context: Context) -> NSTextView {
//
//        let uiTextView = NSTextView()
//        uiTextView.delegate = context.coordinator
//
//        // Configure text view as desired...
//        uiTextView.font = NSFont(name: "HelveticaNeue", size: 15)
//
//        return uiTextView
//    }
//
//    func updateUIView(_ uiView: NSTextView, context: Context) {
//        uiView.string = self.text ?? ""
//        // Compute the desired height for the content
//        let fixedWidth = uiView.frame.size.width
//        let newSize = uiView.sizeth
//
//        DispatchQueue.main.async {
//            self.desiredHeight = newSize.height
//        }
//    }
//
//    class Coordinator : NSObject, NSTextViewDelegate {
//
//        var parent: PromptTextView
//
//        init(_ view: PromptTextView) {
//            self.parent = view
//        }
//        
//        func textDidEndEditing(_ notification: Notification) {
//            DispatchQueue.main.async {
//                self.parent.text =
//            }
//        }
//
////        func textViewDidEndEditing(_ textView: NSTextView) {
////            DispatchQueue.main.async {
////                self.parent.text = textView.text
////                self.parent.attributedText = textView.attributedText
////            }
////        }
//    }
//}
