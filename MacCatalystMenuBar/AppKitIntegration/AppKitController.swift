//
//  AppKitController.swift
//  AppKitIntegration
//
//  Created by Steven Troughton-Smith on 29/09/2020.
//

import AppKit
import SwiftUI


@objc class AppKitController: NSObject {
    let statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    var popover: NSPopover!

    override init() {
        super.init()
        
        NSLog("[AppKitController] Loaded successfully")
        
        setupMenuItem()
    }
    
    func setupMenuItem() {
        
        let menuBarView = MenuBarView()

        // Create the popover
        let popover = NSPopover()
        popover.contentSize = NSSize(width: 400, height: 400)
        popover.behavior = .transient
        
        //########################################################################
        //########################################################################
        //########################################################################
        
        //Comment out this line to make MenuBar Item appear
        popover.contentViewController = NSHostingController(rootView: menuBarView)
        
        //########################################################################
        //########################################################################
        //########################################################################
        
        self.popover = popover
        
        if let button = self.statusBarItem.button {
            button.image = NSImage(named: "MenuBar")
            button.action = #selector(togglePopover(_:))
        }
        
        NSApp.activate(ignoringOtherApps: true)
        
        
        //statusItem.menu = createMenu()
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
    
    func createMenu() -> NSMenu {
        let menu = NSMenu()
        let menuItem = menu.addItem(withTitle: "My Menu", action: #selector(doThing), keyEquivalent: "")
        menuItem.target = self
        
        return menu
    }
    
    @objc func doThing(_ sender:Any?) {
        NSLog("Did the thing")
    }
}

struct MenuBarView: View {
    var body: some View{
        VStack{
            Text("My Menu")
        }
    }
}
