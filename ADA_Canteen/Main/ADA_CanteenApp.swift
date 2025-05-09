//import SwiftUI
//
//@main
//struct ADA_Canteen: App{
//    
//    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
//    
//    var body: some Scene{
//        WindowGroup{
//            ContentView()
//        }
//        Settings{}
//    }
//}
//

import SwiftUI

@main
struct ADA_Canteen: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        #if os(macOS)
        // macOS-specific code
        WindowGroup {
            ContentView() // Display ContentView for macOS
        }
        Settings{}
        #elseif os(iOS)
        // iOS-specific code
        WindowGroup {
            SplashScreen() // Display SplashScreen for iOS
        }
        #endif
    }
}

