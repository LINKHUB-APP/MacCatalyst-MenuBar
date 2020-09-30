//
//  AppKitController.swift
//  AppKitIntegration
//
//  Created by Steven Troughton-Smith on 29/09/2020.
//

import AppKit
import SwiftUI
import Cocoa

@objc class AppKitController: NSObject {
    //let statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    var statusBarItem: StatusBarItemControler!

    override init() {
        super.init()
        
        NSLog("[AppKitController] Loaded successfully")
        self.statusBarItem = StatusBarItemControler()
        self.statusBarItem.updateTitle()
        self.statusBarItem.updateMenu()
    }
}

class StatusBarItemControler {
    let item: NSStatusItem

    init() {
        self.item = NSStatusBar.system.statusItem(
            withLength: NSStatusItem.variableLength
        )
        let statusBarMenu = NSMenu(title: "MeetingBar in Status Bar Menu")
        self.item.menu = statusBarMenu
        
    }

    func updateTitle() {
        var title = "MeetingBar"

        DispatchQueue.main.async {
            if let button = self.item.button {
                button.title = "\(title)"
            }
        }
    }

    func updateMenu() {
        if let statusBarMenu = self.item.menu {
            statusBarMenu.autoenablesItems = false
            statusBarMenu.removeAllItems()

            //let today = Date()
            //let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!
            //self.createDateSection(date: today, title: "Today")
            
            statusBarMenu.addItem(NSMenuItem.separator())
            self.createDateSection(date: tomorrow, title: "All Links")
            statusBarMenu.addItem(NSMenuItem.separator())
            self.createPreferencesSection()
        }
    }

    func createPreferencesSection() {
        self.item.menu!.addItem(
            withTitle: "Preferences",
            action: #selector(openPrefecencesWindow),
            keyEquivalent: ",")
        self.item.menu!.addItem(
            withTitle: "Quit",
            action: #selector(quit),
            keyEquivalent: "q")
    }
    
    
    @objc func openPrefecencesWindow(_: NSStatusBarButton?) {
            NSLog("Open preferences window")
        }
    
    @objc func quit(_: NSStatusBarButton?) {
            NSLog("Open preferences window")
        }


    func createDateSection(date: Date, title: String) {
        /*let events: [EKEvent] = self.eventStore.loadEventsForDate(calendars: self.calendars, date: date)

        // Header
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM"
        let dateString = dateFormatter.string(from: date)
        let dateTitle = "\(title) events (\(dateString)):"
        let titleItem = self.item.menu!.addItem(
            withTitle: dateTitle,
            action: nil,
            keyEquivalent: "")
        titleItem.attributedTitle = NSAttributedString(string: dateTitle, attributes: [NSAttributedString.Key.font: NSFont.boldSystemFont(ofSize: 13)])
        titleItem.isEnabled = false

        // Events
        let sortedEvents = events.sorted { $0.startDate < $1.startDate }
        if sortedEvents.isEmpty {
            let item = self.item.menu!.addItem(
                withTitle: "Nothing for \(title.lowercased())",
                action: nil,
                keyEquivalent: "")
            item.isEnabled = false
        }
        for event in sortedEvents {
            self.createEventItem(event: event)
        }*/
    }
    
    func createAllLinksSection(date: Date, title: String) {
            // Header
            let dateTitle = "\(title)"
            let titleItem = self.item.menu!.addItem(
                withTitle: dateTitle,
                action: nil,
                keyEquivalent: "")
            titleItem.attributedTitle = NSAttributedString(string: dateTitle, attributes: [NSAttributedString.Key.font: NSFont.boldSystemFont(ofSize: 13)])
            titleItem.isEnabled = false

            // Events
            let sortedEvents = events.sorted { $0.startDate < $1.startDate }
            if sortedEvents.isEmpty {
                let item = self.item.menu!.addItem(
                    withTitle: "Nothing for \(title.lowercased())",
                    action: nil,
                    keyEquivalent: "")
                item.isEnabled = false
            }
            for event in sortedEvents {
                self.createEventItem(event: event)
            }
        }
    
    @objc
        func clickOnEvent(sender: NSMenuItem) {
            NSLog("Click on event (\(sender.title))!")
            let event: String = sender.representedObject as! String
            openEvent(event)
        }
    
    func openEvent(_ event: String) {
        let eventTitle = event ?? "No title"

        print(eventTitle)
    }

    func createEventItem(event: EKEvent) {
        let now = Date()

        let eventTitle = String(event.title)

        let eventTimeFormatter = DateFormatter()

        //eventTimeFormatter.dateFormat = "h:mm a"
        eventTimeFormatter.dateFormat = "HH:mm"

        var eventStartTime = ""
        if event.isAllDay {
            eventStartTime = "All day"
        } else {
            eventStartTime = eventTimeFormatter.string(from: event.startDate)
        }

        // Event Item
        let eventItem = self.item.menu!.addItem(
            withTitle: eventTitle,
            action: #selector(clickOnEvent(sender:)),
            keyEquivalent: "")
    }
}
