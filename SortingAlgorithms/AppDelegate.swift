//
//  AppDelegate.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 02.08.2023.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var window: NSWindow?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        showMainWindow()
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        
    }
    
    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}

extension AppDelegate {
    func showMainWindow() {
        NSApplication.shared.activate(ignoringOtherApps: true)
        guard window == nil else {
            window?.makeKeyAndOrderFront(self)
            return
        }
        let mainController = MainModuleAssembly.configureModule()
        window = configureMainWindow(for: mainController)
        window?.makeKeyAndOrderFront(nil)
    }
    
    private func configureMainWindow(for contentViewController: NSViewController) -> NSWindow {
        let windowSize = NSSize(width: 600, height: 400)
        
        let newWindow = NSWindow(
            contentRect: NSRect(origin: CGPoint(), size: windowSize),
            styleMask: [.titled, .closable, .miniaturizable],
            backing: .buffered,
            defer: false
        )
        newWindow.contentViewController = contentViewController
        
        newWindow.contentMinSize = windowSize
        newWindow.contentMaxSize = windowSize

        newWindow.title = "SortingAlgorithms"
        newWindow.delegate = self
        newWindow.isReleasedWhenClosed = false
        newWindow.center()
        
        return newWindow
    }
}

extension AppDelegate: NSWindowDelegate {
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        if !flag {
            self.showMainWindow()
        }
        return true
    }
}

