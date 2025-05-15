import SwiftUI

@main
struct ADA_Canteen: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        #if os(macOS)
        WindowGroup {
            ContentView()
        }
        Settings{}
        #elseif os(iOS)
        WindowGroup {
            SplashScreen()
        }
        #endif
    }
}

