//
//  TenantDetailView.swift
//  ADA Kantin
//
//  Created by Alvin Justine on 19/05/25.
//

import SwiftUI

struct TenantDetailView: View {
    @State private var searchText = ""
    @State private var isFilterViewPresented = false
    @State private var filterModel = FilterModel()
    
    var filteredFoodItems: [FoodItem] {
        tenant.foodItems.filter { food in
            // Price filter
            let priceFilter = Double(food.price) <= filterModel.maxPrice
            
            // Category filter (if any categories selected)
            let categoryFilter = filterModel.selectedFoodCategories.isEmpty ||
            food.tags.contains { filterModel.selectedFoodCategories.contains($0) }
            
            // Search text filter
            let searchFilter = searchText.isEmpty ||
            food.name.localizedCaseInsensitiveContains(searchText)
            
            return priceFilter && categoryFilter && searchFilter
        }
    }
    
    let tenant: TenantItem
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                // Search Bar
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white)
                            .frame(width: 25, height: 25)
                            .background(Color("aksen"))
                            .cornerRadius(5)
                        
                        TextField("Mau makan apa, nih?", text: $searchText)
                            .font(.system(size: 14, weight: .light))
                            .foregroundColor(.black)
                        
                        if !searchText.isEmpty {
                            Button(action: {
                                searchText = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding(8)
//                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    
                    // Filter Button
                    Button {
                        isFilterViewPresented = true
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                            .padding(.leading, 5)
                            .foregroundColor(Color(.gray))
                    }
                }
                .padding(.horizontal)
                .padding(.top)
                
                ScrollView {
                    // Background Image with Logo Overlay
                    ZStack(alignment: .bottom) {
                        // Background Image
                        Image(tenant.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 130)
                            .clipped()
                        
                        // Logo and Info in HStack
                        HStack(alignment: .bottom, spacing: 20) {
                            // Logo
                            Image(tenant.logo)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .foregroundColor(.white)
                                .background(Color.white)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                                .shadow(radius: 5)
                                .offset(y: 30)
                                .padding(.leading, 20)
                            
                            Spacer()
                            // Tenant Info VStack
                        }
                        .padding(.bottom, 10)
                        VStack(alignment: .leading, spacing: 6) {
                            // Tenant Name
                            Text(tenant.name)
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                            
                            // Price Range
                            Text(tenant.priceRangeString)
                                .font(.system(size: 16))
//                                    .foregroundColor(.secondary)
                                .fontWeight(.medium)
                            
                            // Deskripsi Tenant
                            Text(tenant.description)
                                .font(.system(size: 12))
                                .foregroundColor(.secondary)
                                .italic()
                                .fixedSize(horizontal: false, vertical: true)
                            // Tag Kategori
                            HStack(spacing: 8) {
                                ForEach(tenant.tags, id: \.self) { tag in
                                    Image(tag)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20, height: 20)
                                }
                            }
                        }
                        .offset(y: 145)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    }
                    .padding(.bottom, 110)
                    
                    // Menu Section
                    VStack {
                        LazyVGrid(
                            columns: [
                                GridItem(.flexible(), spacing: 16),
                                GridItem(.flexible(), spacing: 16)
                            ],
                            spacing: 16
                        ) {
                            ForEach(filteredFoodItems) { item in
                                NavigationLink(destination: FoodDetailView(foodItem: item)) {
                                    FoodCard(item: item)
                                        .frame(width: 150)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 16)
                    }
                    .padding(.top, 40)
                    .sheet(isPresented: $isFilterViewPresented) {
                        FoodFilterView(filterModel: $filterModel)
                    }
                }
            }
        }
    }
}
