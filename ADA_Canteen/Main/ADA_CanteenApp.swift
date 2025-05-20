import SwiftUI

@main
struct ADA_Canteen: App{
    var body: some Scene{
        #if os(macOS)
        WindowGroup{
            ContentView()
        }
        MenuBarExtra{
            MenubarFoodView()
        } label: {
            Image(systemName: "fork.knife")
        }
        .menuBarExtraStyle(.window)
        
        Settings{}
        
        #elseif os(iOS)
        WindowGroup{
            SplashScreen()
        }
        #endif
    }
}

//Entry Point Aplikasi
