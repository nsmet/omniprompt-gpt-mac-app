//
//  GifImageView.swift
//  BreezeAI
//
//  Created by Saqib Omer on 17/05/2023.
//

import SwiftUI
import WebKit
import Quartz

struct QLImage: NSViewRepresentable {
    
    private let name: String

    init(_ name: String) {
        self.name = name
    }
    
    func makeNSView(context: NSViewRepresentableContext<QLImage>) -> QLPreviewView {
        guard let url = Bundle.main.url(forResource: name, withExtension: "gif")
        else {
            let _ = print("Cannot get image \(name)")
            return QLPreviewView()
        }
        
        let preview = QLPreviewView(frame: .zero, style: .normal)
        preview?.autostarts = true
        preview?.previewItem = url as QLPreviewItem
        
        return preview ?? QLPreviewView()
    }
    
    func updateNSView(_ nsView: QLPreviewView, context: NSViewRepresentableContext<QLImage>) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "gif")
        else {
            let _ = print("Cannot get image \(name)")
            return
        }
        nsView.previewItem = url as QLPreviewItem
    }
    
    typealias NSViewType = QLPreviewView
}

//struct GIFView: NSViewRepresentable {
//    var imageName: String
//    var width: CGFloat
//    var height: CGFloat
//
//    func makeNSView(context: Context) -> NSImageView {
//        let imageView = NSImageView()
//        imageView.image = NSImage(named: imageName)
//        imageView.animates = true // Enables animation
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.widthAnchor.constraint(equalToConstant: width).isActive = true
//        imageView.heightAnchor.constraint(equalToConstant: height).isActive = true
//        return imageView
//    }
//
//    func updateNSView(_ nsView: NSImageView, context: Context) {
//        // Update the view if needed
//    }
//}
struct GIFImageView: NSViewRepresentable {
    var imageName: String
    var width: CGFloat
    var height: CGFloat
    
    func makeNSView(context: Context) -> NSImageView {
        let imageView = NSImageView()
        imageView.image = NSImage(named: imageName)
        imageView.animates = true // Enables animation
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: width).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: height).isActive = true
        return imageView
    }

    func updateNSView(_ nsView: NSImageView, context: Context) {
        if let gifImage = NSImage(named: NSImage.Name(imageName)) {
            nsView.image = gifImage
            nsView.animates = true
        }
    }
}
