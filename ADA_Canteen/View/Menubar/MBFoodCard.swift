//
//  MenubarFoodCardView.swift
//  ADA Kantin
//
//  Created by Alvin Justine on 19/05/25.
//

import SwiftUI
struct MBFoodCard: View {
    let item: FoodItem

    var body: some View {
        HStack(spacing: 12) {
            // Food image
            Image(item.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .cornerRadius(8)
                .clipped()

            // Textual info
            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.headline)              // bolder title
                    .foregroundColor(.primary)
                    .lineLimit(1)

                Text(item.location)
                    .font(.subheadline)           // slightly larger caption
                    .foregroundColor(.secondary)

                Text("Rp \(item.price.formattedWithSeparator)")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
            }

            Spacer()
        }
        .padding(.vertical, 8)
        .padding(.horizontal)
        .background(Color.white)
        .cornerRadius(10)
        .overlay(                                      // light border
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.05),      // subtle shadow
                radius: 4, x: 0, y: 2)
    }
}

//import SwiftUI
//
//struct MBFoodCard: View {
//    let item: FoodItem
//
//    var body: some View {
//        HStack {
//            Image(item.image)
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: 60, height: 60)
//                .cornerRadius(8)
//                .clipped()
//
//            VStack(alignment: .leading) {
//                Text(item.name)
//                    .fontWeight(.medium)
//                    .lineLimit(1)
//
//                Text(item.location)
//                    .font(.caption)
//                    .foregroundColor(.secondary)
//
//                Text("\(item.price)")
//                    .foregroundColor(.black)
//                    .fontWeight(.semibold)
//            }
//            .padding(.leading, 6)
//        }
//        .padding(.bottom, 8)
//        .background(Color.white)
//        .cornerRadius(8)
//        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
//    }
//}
