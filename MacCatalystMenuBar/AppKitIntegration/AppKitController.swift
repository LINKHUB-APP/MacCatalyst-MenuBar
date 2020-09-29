//
//  AppKitController.swift
//  AppKitIntegration
//
//  Created by Steven Troughton-Smith on 29/09/2020.
//

import AppKit

@objc class AppKitController: NSObject {
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)

    override init() {
        super.init()
        
        NSLog("[AppKitController] Loaded successfully")
        
        setupMenuItem()
    }
    
    func setupMenuItem() {
        
        statusItem.image = NSImage(named: "MenuBar")
        
        statusItem.menu = createMenu()
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
