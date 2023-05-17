//
//  ContentViewModel.swift
//  Core
//
//  Created by Saqib Omer on 12/05/2023.
//

import SwiftUI
import Combine

public final class ContentViewModel: ObservableObject {

    @Published public var searchBar = ""
    @Published public var clipBoard = false
    @Published public var textEditor = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus rhoncus elit ac dolor venenatis imperdiet. Vivamus sodales eros enim, vitae blandit nisi consectetur a. Mauris feugiat gravida sem, in efficitur dolor lacinia a. Sed vitae leo fermentum, fringilla eros vel, malesuada turpis. Suspendisse sem turpis, posuere sit amet nunc non, lobortis mollis quam. Curabitur auctor fringilla mi. In et consequat tellus, ut porta magna. Aliquam a elit dapibus, accumsan ipsum at, egestas leo. Nunc euismod lacus eget ultricies vestibulum. Nullam in ante ut lectus congue euismod ut eget lectus. Aliquam ut arcu cursus, aliquet risus et, tincidunt sem. Proin et felis lacinia, euismod risus non, semper elit. Donec tincidunt sagittis nisl id ullamcorper. Curabitur egestas tristique nisi, at rhoncus nisi vulputate non. Quisque at posuere tellus. Nunc viverra urna ipsum, et pulvinar tellus varius ac. Praesent fringilla nisi in molestie iaculis. Vestibulum sit amet tincidunt sem, eu placerat eros. Donec aliquam diam id maximus finibus. Aenean tincidunt diam tincidunt, sagittis nibh nec, dignissim mi. Phasellus ac consequat ex. Nulla nec aliquet felis. Etiam justo mi, vehicula at porttitor vel, dictum vitae lectus. Nulla tempor massa ante, ut venenatis ante fringilla sed. Suspendisse consectetur dictum velit, sit amet viverra nisi ultricies quis. Curabitur vitae dolor at odio faucibus cursus. Nam ut facilisis mauris, at ullamcorper urna. Ut vitae facilisis nibh. Nam id risus ipsum. Sed posuere felis eu sem varius facilisis. Nunc sed elementum leo. Maecenas pharetra mi nec turpis commodo, quis fringilla est fringilla. Nullam et lacinia sapien, non semper ante. Duis tortor nulla, blandit id libero vitae, sollicitudin tristique est. Quisque porta porta ex eu volutpat. Phasellus ullamcorper, odio non convallis vestibulum, eros erat luctus neque, nec pellentesque turpis nisi ac nisi. Vivamus at magna nec odio mollis aliquet. Donec nec tortor in mi fringilla efficitur sed a odio. Mauris dapibus ultricies nibh, sit amet fringilla ipsum congue eget. Nam malesuada nibh erat, sed tempus sapien pulvinar eget. Integer eu luctus metus, quis congue metus."
    @Published public var showLoadingAnimation = false
    
    
    public init() {
        
    }
}
