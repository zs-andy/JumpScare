//
//  FlashWindow.swift
//  JumpScare
//
//  Created by Andy Lyu on 9/25/25.
//
import Cocoa

class FlashWindow: NSWindow {
    override init(contentRect: NSRect,
                  styleMask: NSWindow.StyleMask,
                  backing: NSWindow.BackingStoreType,
                  defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: styleMask, backing: backing, defer: flag)
        self.isOpaque = false
        self.backgroundColor = .black
        self.level = .statusBar
        self.ignoresMouseEvents = true
    }
    
    var flashTimer: Timer?
    var flashWindow: NSWindow?

    func startFlashing() {
        guard let screenFrame = NSScreen.main?.frame else { return }
        flashWindow = FlashWindow(contentRect: screenFrame, styleMask: .borderless, backing: .buffered, defer: false)
        flashWindow?.makeKeyAndOrderFront(nil)
        
        flashTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            self.flashWindow?.alphaValue = self.flashWindow?.alphaValue == 0 ? 1 : 0
        }
    }

    func stopFlashing() {
        flashTimer?.invalidate()
        flashTimer = nil
        flashWindow?.orderOut(nil)   // 👈 隐藏窗口
        flashWindow = nil
    }
}
