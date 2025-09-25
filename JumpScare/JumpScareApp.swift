//
//  JumpScareApp.swift
//  JumpScare
//
//  Created by Andy Lyu on 9/25/25.
//

import SwiftUI

@main
struct JumpScareApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        Settings { EmptyView() }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem!
    var floating: FloatingGifWindow?

    func applicationDidFinishLaunching(_ notification: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusItem.button?.title = "👻"

        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "显示", action: #selector(showGif), keyEquivalent: "s"))
        menu.addItem(NSMenuItem(title: "退出", action: #selector(quit), keyEquivalent: "q"))
        statusItem.menu = menu
    }

    @objc func showGif() {
        floating = FloatingGifWindow(gifName: "halloween", size: CGSize(width: 800, height: 800))
        floating?.show()
    }

    @objc func quit() {
        NSApplication.shared.terminate(nil)
    }
}
