//
//  MacPlugin.swift
//  Test
//
//  Created by Julian Beaulieu on 9/28/20.
//

import Foundation


@objc(Plugin)
protocol Plugin: NSObjectProtocol {
    init()

    func sayHello()
}
