//
//  GIFImage.swift
//  JumpScare
//
//  Created by Andy Lyu on 9/25/25.
//

import SwiftUI
import AppKit

struct FloatingGifWindow {
    private var window: NSWindow!

    init(gifName: String, size: CGSize = CGSize(width: 200, height: 200)) {
        let contentView = GifImage(gifName)
            .frame(width: size.width, height: size.height)

        let hosting = NSHostingView(rootView: contentView)
        window = NSPanel(
            contentRect: NSRect(x: 0, y: 0, width: size.width, height: size.height),
            styleMask: [.borderless],
            backing: .buffered,
            defer: false
        )

        window.contentView = hosting
        window.isOpaque = false
        window.backgroundColor = .clear
        window.level = .floating
        window.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        window.hasShadow = false
        window.ignoresMouseEvents = true
        window.hidesOnDeactivate = false
        
    }

    func show(duration: TimeInterval = 2.0) {
        if let screen = NSScreen.main {
            let screenFrame = screen.visibleFrame
            let x = screenFrame.midX - window.frame.width / 2
            let y = screenFrame.midY - window.frame.height / 2
            window.setFrameOrigin(NSPoint(x: x, y: y))
        }
        window.makeKeyAndOrderFront(nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            window.orderOut(nil)
        }
    }
}

struct GifImage: NSViewRepresentable {
    private let name: String
    
    init(_ name: String) {
        self.name = name
    }
    
    func makeNSView(context: Context) -> NSImageView {
        let imageView = NSImageView()
        imageView.canDrawSubviewsIntoLayer = true
        imageView.imageScaling = .scaleProportionallyUpOrDown
        
        if let url = Bundle.main.url(forResource: name, withExtension: "gif"),
           let data = try? Data(contentsOf: url),
           let image = NSImage(data: data) {
            imageView.image = image
            imageView.animates = true
        }
        
        return imageView
    }
    
    func updateNSView(_ nsView: NSImageView, context: Context) {
        
    }
}


struct GifImage_Previews: PreviewProvider {
    static var previews: some View {
        GifImage("snow")
            .frame(width: 300, height: 300)
    }
}

