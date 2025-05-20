//
//  FoodDetailView.swift
//  ADA Kantin
//
//  Created by Alvin Justine on 19/05/25.
//

import SwiftUI

struct FoodDetailView: View {
    let foodItem: FoodItem
    
    var tenant: TenantItem? {
        DataHelper.loadTenants().first(where: { $0.id == foodItem.tenantId})
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                Image(foodItem.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 250)
                    .frame(width: 370)
                    .cornerRadius(8)
                    .clipped()
                    .padding(.bottom, 20)
                VStack(spacing: 16) {
                    VStack(spacing: 4) {
                        HStack {
                            Text(foodItem.name)
                                .font(.title)
                                .fontWeight(.medium)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 18)
                                .font(.system(size: 24))
                            Text("\(foodItem.price)")
                                .font(.title)
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.trailing, 18)
                                .font(.system(size: 24))
                                .foregroundColor(Color(.black))
                        }
                        
//                        BAGIAN INI, DIUBAH JADI TAG BERUPA TEKS AJA
                        
//                        HStack(alignment: .center, spacing: 8) {
//                            ForEach(foodItem.tags, id: \.self) { tag in
//                                Image(tag)
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 30, height: 30)
//                            }
//                        }
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.top, 5)
//                        .padding(.bottom, 9)
//                        .padding(.leading, 18)
                            
                            Text(foodItem.foodDescription)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .padding(.bottom, 10)

                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)



                        if let tenant: TenantItem {
                            NavigationLink(destination: TenantDetailView(tenant: tenant)) {
                                HStack {
                                    Image(tenant.image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(8)
                                        .clipped()
                                        .padding(.trailing, 5)

                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(tenant.name)
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                        
                                        Text(tenant.description)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                            .lineLimit(2)
                                            .italic()
                                    }
                                    Spacer()
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .padding(.horizontal)
                            
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}
