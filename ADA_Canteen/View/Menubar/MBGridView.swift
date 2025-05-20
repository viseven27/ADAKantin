//
//  MBGridView.swift
//  ADA Kantin
//
//  Created by Alvin Justine on 19/05/25.
//

import SwiftUI

struct MBGridView: View {
    let foodItems: [FoodItem]

    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible(), spacing: 16)], spacing: 8) {
            ForEach(foodItems) { item in
                /*NavigationLink(destination: FoodDetailView(foodItem: item))*/ /*{*/
                    MBFoodCard(item: item)
                        .frame(width: 270)
//                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        
        .padding(.horizontal)
        .padding(.bottom, 16)
//        .background(.white)
    }
}
