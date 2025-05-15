//
//  DelegateFoodCard.swift
//  ADA Kantin
//
//  Created by Alvin Justine on 15/05/25.
//

import SwiftUI

struct DelegateFoodCard: View {
    let item: FoodItem
    
    var body: some View{
        HStack(spacing: 12){
            Image(item.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .clipped()
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 4){
                Text(item.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(item.location)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(String(format: "Rp %.0f", item.price))
                    .font(.subheadline)
                    .foregroundColor(.primary)
            }
        }
        .padding(12)
        .background(Color(NSColor.windowBackgroundColor))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

//Projek
// Ada CoffeeInThePantry (Done)
//Belum bwt bindable
//Belum buat observable
//Belum buat @Environment (Semua ini adalah property wrapper)
// Belum explore macro
// Belum buat property wrapper sendiri

//Interactions
// Shape View
// Canvas View
// Geometry Reader View
// Sensory Feedback Modifier
// Styling using Style Modifier (Done)
// .modifier to abstract your view styling
// Use Linear Gradient View
// Use Gesture Modifier on a view (More than tap)
// Use symbol effects on the SF symbol
// .animation modifier

// withanimation()
// .animation when variable change happen
// Use TimelineView to do view updates
// navigationTransition


