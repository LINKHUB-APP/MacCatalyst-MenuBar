//
//  AppKitGlue.swift
//  AppKitGlue
//
//  Created by Julian Beaulieu on 9/28/20.
//

import AppKit

class AppKitGlue: NSObject, Plugin {
    var window: NSWindow!
    var popover: NSPopover!
    var statusBarItem: NSStatusItem!
    
    required override init() {
    }

    func sayHello() {
//        let alert = NSAlert()
//        alert.alertStyle = .informational
//        alert.messageText = "Eyyyyyyyy it works mf!"
//        alert.informativeText = "It Works!"
//        alert.addButton(withTitle: "OK")
//        alert.runModal()
        
        
        // Create the popover
        let popover = NSPopover()
        popover.contentSize = NSSize(width: 400, height: 400)
        popover.behavior = .transient
        //popover.contentViewController = NSHostingController(rootView: MenuBarView)
        self.popover = popover

       // Create the status item
        self.statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))

        if let button = self.statusBarItem.button {
            button.image = NSImage(named: "MenuBar")
            button.action = #selector(togglePopover(_:))
        }

        NSApp.activate(ignoringOtherApps: true)
    }
    
    @objc func togglePopover(_ sender: AnyObject?) {
        if let button = self.statusBarItem.button {
            if self.popover.isShown {
                self.popover.performClose(sender)
            } else {
                self.popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            }
        }
    }
}
