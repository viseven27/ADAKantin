//
//  MenubarSearchView.swift
//  ADA Kantin
//
//  Created by Alvin Justine on 19/05/25.
//
import SwiftUI

struct MenubarSearchView: View {
    @Binding var searchText: String
    var onFilterTapped: () -> Void

    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.black)
                    .frame(width: 25, height: 25)
                    .cornerRadius(5)

                TextField("Cari Makanan di Green Eatery", text: $searchText)
                    .font(.system(size: 14))
                    .foregroundColor(.black)

                if !searchText.isEmpty {
                    Button(action: { searchText = "" }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(8)
            .cornerRadius(10)

//            Button(action: onFilterTapped) {
//                Image(systemName: "line.3.horizontal.decrease")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 24, height: 24)
//                    .foregroundColor(.gray)
//            }
//            Buttonnya harus diupdate supaya bisa ada dua, and each work only for either price or category
        }
        .padding()
//        .background(.white)
    }
}
