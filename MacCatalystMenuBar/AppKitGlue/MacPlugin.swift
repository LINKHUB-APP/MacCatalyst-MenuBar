//
//  File.swift
//  AppKitGlue
//
//  Created by Julian Beaulieu on 9/28/20.
//

import AppKit

class MacPlugin: NSObject, Plugin {
    required override init() {
    }

    func sayHello() {
        let alert = NSAlert()
        alert.alertStyle = .informational
        alert.messageText = "Hello from AppKit!"
        alert.informativeText = "It Works!"
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
}
