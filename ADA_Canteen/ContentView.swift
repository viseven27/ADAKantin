//
//  ContentView.swift
//  ADA_Canteen
//
//  Created by Daven Karim on 21/03/25.
//

import SwiftUI

struct ContentView: View {
    init() {
        // Mengatur warna latar belakang tab bar
        UITabBar.appearance().backgroundColor = UIColor.systemBackground
        // Mengatur warna tab yang aktif (warna kuning)
        UITabBar.appearance().tintColor = UIColor(Color("aksen"))
    }
    
    var body: some View {
        TabView {
            Food()
                .tabItem {
                    VStack {
                        Image(systemName: "fork.knife")
                        Text("Foods")
                    }
                }
            
            Tenant()
                .tabItem {
                    VStack {
                        Image(systemName: "storefront.fill")
                        Text("Tenants")
                            .fontWeight(.black)
                    }
                }
        }
        .accentColor(Color("aksen")) // Ngatur warna accent satu apllikasi jadi kuning
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
