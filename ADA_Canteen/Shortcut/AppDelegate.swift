//import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate{
    var statusItem: NSStatusItem?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        setupMenuBarItem()
    }
    
    func setupMenuBarItem(){
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = statusItem?.button{
            button.title = "Kantin"
        }
        
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Makan", action: nil, keyEquivalent: ""))
//        how so it not only displaying the text
    
        statusItem?.menu = menu
//        DelegateContentView()
    }
}
