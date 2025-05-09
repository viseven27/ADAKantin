import SwiftUI

struct ContentView: View {
//    init() {
//        UITabBar.appearance().backgroundColor = UIColor.systemBackground
//        UITabBar.appearance().tintColor = UIColor(Color("aksen"))
//    }
    
    var body: some View {
        TabView {
            Food()
                .tabItem {
                    VStack {
                        Image(systemName: "fork.knife")
                        Text("Makanan")
                    }
                }
            Tenant()
                .tabItem {
                    VStack {
                        Image(systemName: "storefront.fill")
                        Text("Tenant")
                            .fontWeight(.black)
                    }
                }
        }
        .accentColor(Color("aksen"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
