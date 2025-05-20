//
//  FoodFilterView.swift
//  ADA Kantin
//
//  Created by Alvin Justine on 19/05/25.
//

import SwiftUI

struct FoodFilterView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var filterModel: FilterModel
    
    let categories = ["kategori.Ayam", "kategori.Sayur", "kategori.Ikan", "kategori.Sapi", "kategori.Cabe", "kategori.Minuman", "kategori.Processed", "kategori.Kacang"]
    
    var body: some View {
        VStack {
            HStack {
                Text("Filter Makanan")
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.top, 30)
            .padding(.bottom, 20)
            .padding(.horizontal)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Group {
                        Text("Kategori")
                            .font(.system(size: 16))
                            .fontWeight(.medium)
                        
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 110))], spacing: 10) {
                            ForEach(categories, id: \.self) { category in
                                Button(action: {
                                    filterModel.toggleFoodCategory(category)
                                }) {
                                    HStack(spacing: 6) {
                                        Image(category)
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                        Text(category.replacingOccurrences(of: "kategori.", with: ""))
                                            .font(.system(size: 12))
                                            .lineLimit(1)
                                            .truncationMode(.tail)
                                        Spacer()
                                    }
                                    .padding(.horizontal, 6)
                                    .frame(width: 115, height: 40)
                                    .background(
                                        filterModel.selectedFoodCategories.contains(category) ?
                                        Color("aksen").opacity(0.2) : Color.gray.opacity(0.1)
                                    )
                                    .cornerRadius(8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(
                                                filterModel.selectedFoodCategories.contains(category) ?
                                                Color("aksen") : Color.clear,
                                                lineWidth: 1
                                            )
                                    )
                                }
                                .foregroundColor(.primary)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                    
                    Group {
                        Text("Harga Maksimum")
                            .font(.system(size: 16))
                            .fontWeight(.medium)
                            .padding(.bottom, 10)
                        
                        HStack {
                            Text("\(Int(filterModel.maxPrice))")
                            Spacer()
                        }
                        
                        Slider(
                            value: $filterModel.maxPrice,
                            in: 0...50000,
                            step: 500
                        )
                        .accentColor(Color("aksen"))
                    }
                    .padding(.horizontal)
                }
            }
            
            HStack {
                Button(action: {
                    filterModel.reset()
                }) {
                    Text("Reset")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color("aksen"))
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                }
                
                Button(action: {
                    dismiss()
                }) {
                    Text("Terapkan Filter")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .padding()
                        .background(Color("aksen"))
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
    }
}
