//
//  TenantFilterView.swift
//  ADA Kantin
//
//  Created by Alvin Justine on 19/05/25.
//

import SwiftUI

struct TenantFilterView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var filterModel: FilterModel

    let categories = ["kategori.Ayam", "kategori.Sayur", "kategori.Ikan", "kategori.Sapi", "kategori.Cabe", "kategori.Minuman", "kategori.Processed", "kategori.Kacang"]
    let priceSteps = Array(stride(from: 0, through: 100000, by: 5000))

    var body: some View {
        VStack {
            HStack {
                Text("Filter Tenant")
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.top, 30)
            .padding(.bottom, 20)
            .padding(.horizontal)

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Category Filter
                    Group {
                        Text("Kategori")
                            .font(.system(size: 20))
                            .fontWeight(.medium)

                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 110))], spacing: 10) {
                            ForEach(categories, id: \.self) { category in
                                Button(action: {
                                    filterModel.toggleTenantCategory(category)
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
                                        filterModel.selectedTenantCategories.contains(category) ?
                                        Color("aksen").opacity(0.2) : Color.gray.opacity(0.1)
                                    )
                                    .cornerRadius(8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(
                                                filterModel.selectedTenantCategories.contains(category) ?
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

                    // Price Range Filter
                    Group {
                        Text("Range Harga")
                            .font(.system(size: 20))
                            .fontWeight(.medium)

                        VStack(alignment: .leading, spacing: 20) {
                            VStack(alignment: .leading) {
                                Text("Minimum: \(filterModel.minPriceFilter?.formattedWithSeparator ?? "0")")
                                    .font(.subheadline)

                                Slider(
                                    value: Binding(
                                        get: {
                                            Double(filterModel.minPriceFilter ?? 0)
                                        },
                                        set: {
                                            filterModel.minPriceFilter = Int($0)
                                        }
                                    ),
                                    in: 0...Double(priceSteps.last ?? 100000),
                                    step: 1000
                                )
                            }
                            .accentColor(Color("aksen"))

                            VStack(alignment: .leading) {
                                Text("Maksimum: \(filterModel.maxPriceFilter?.formattedWithSeparator ?? "100.000")")
                                    .font(.subheadline)

                                Slider(
                                    value: Binding(
                                        get: {
                                            Double(filterModel.maxPriceFilter ?? 100000)
                                        },
                                        set: {
                                            filterModel.maxPriceFilter = Int($0)
                                        }
                                    ),
                                    in: 0...Double(priceSteps.last ?? 100000),
                                    step: 1000
                                )
                            }
                            .accentColor(Color("aksen"))
                        }
                    }
                    .padding(.horizontal)
                }
            }

            // Apply and Reset Buttons
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
