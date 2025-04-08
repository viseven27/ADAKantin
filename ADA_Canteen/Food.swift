//
//  Food.swift
//  ADA_Canteen
//
//  Created by Daven Karim on 22/03/25.
//

import SwiftUI

struct FoodItem: Identifiable {
    let id = UUID()
    let name: String
    let price: Int
    let image: String
    let tags: [String]
    let location: String
    let foodDescription: String
    let tenantId: Int
}

struct Food: View {
    @State private var searchText = ""
    @State private var isFilterViewPresented = false
    @State private var filterModel = FilterModel()
    
    let foodItems = DataHelper.loadTenants().flatMap(\.foodItems)
    
    var filteredFoodItems: [FoodItem] {
        foodItems.filter { food in
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
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Search Bar
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white)
                            .frame(width: 25, height: 25)
                            .background(Color("aksen"))
                            .cornerRadius(5)
                        
                        TextField("Mau makan apa, nih??", text: $searchText)
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
                    .background(Color(.systemGray6))
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
                            .foregroundColor(Color("aksen"))
                    }
                }
                .padding()
                
                // Main Content
                VStack {
                    Text("Foods")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    //                        .padding(.leading, 14)
                    
                    ScrollView {
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
                }
                .padding(.top, 8)
                .sheet(isPresented: $isFilterViewPresented) {
                    FoodFilterView(filterModel: $filterModel)
                }
            }
        }
    }
}


struct FoodCard: View {
    let item: FoodItem
    
    var body: some View {
        VStack(alignment: .leading) {
            // Food Image
            Image(item.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 180)
                .frame(width: 180)
                .cornerRadius(8)
                .clipped()
            
            // Food Name
            Text(item.name)
                .font(.headline)
                .lineLimit(1)
            
            // Location
            Text(item.location)
                .font(.caption)
                .foregroundColor(.secondary)
            
            // Price
            Text("Rp \(item.price)")
                .foregroundColor(.black)
            
            
            // Tag Kategori
            HStack(spacing: 4) {
                ForEach(item.tags, id: \.self) { tag in
                    Image(tag)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
                Spacer()
            }
        }
        .padding(.bottom, 8)
    }
}

struct FoodDetailView: View {
    let foodItem: FoodItem
    
    var tenant: TenantItem? {
        DataHelper.loadTenants().first(where: { $0.id == foodItem.tenantId})
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                
                // Food Image
                Image(foodItem.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 250)
                    .frame(width: 370)
                    .cornerRadius(8)
                    .clipped()
                    .padding(.bottom, 20)
                
                // Food Info Section
                VStack(spacing: 16) {
                    
                    // Food Name and Price
                    VStack(spacing: 4) {
                        HStack {
                            Text(foodItem.name)
                                .font(.title)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 18)
                                .font(.system(size: 24))
                            
                            Text("Rp \(foodItem.price)")
                                .font(.title)
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.trailing, 18)
                                .font(.system(size: 24))
                                .foregroundColor(Color("aksen"))
                        }
                        
                        // Tag Kategori
                        HStack(spacing: 4) {
                            ForEach(foodItem.tags, id: \.self) { tag in
                                Image(tag)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .padding(.top, 5)
                                    .padding(.bottom, 9)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 18)
                            }
                        }
                        
                        // Divider
                        Divider()
                            .padding(.horizontal)
                            .padding(.bottom, 10)
                        
                        // Description Section
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Deskripsi")
                                .font(.headline)
                            
                            Text(foodItem.foodDescription)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .padding(.bottom, 10)
                        }
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        // Divider
                        Divider()
                            .padding(.horizontal)
                            .padding(.bottom, 15)
                        
                        // Tenant Button
                        if let tenant: TenantItem {
                            NavigationLink(destination: TenantDetailView(tenant: tenant)) {
                                HStack {
                                    // Tenant Logo
                                    Image(tenant.image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(8)
                                        .clipped()
                                        .padding(.trailing, 5)
                                    
                                    // Tenant Info
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
                                    
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
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
        .navigationTitle("Food Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// FoodFilterView.swift
struct FoodFilterView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var filterModel: FilterModel
    
    let categories = ["kategori.Ayam", "kategori.Sayur", "kategori.Ikan", "kategori.Sapi", "kategori.Cabe", "kategori.Minuman", "kategori.Kaleng"]
    
    var body: some View {
        VStack() {
            HStack {
                Text("Filter Makanan")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            .padding(.top, 30)
            .padding(.bottom, 20)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    
                    // Category Filter
                    Group {
                        Text("Kategori")
                            .font(.headline)
                        
                        
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10) {
                            ForEach(categories, id: \.self) { category in
                                Button(action: {
                                    filterModel.toggleFoodCategory(category)
                                }) {
                                    HStack {
                                        Image(category)
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                        Text(category.replacingOccurrences(of: "kategori.", with: ""))
                                            .font(.subheadline)
                                    }
                                    //                                    .padding()
                                    .frame(width: 115, height: 45)
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
                    
                    // Price Filter
                    Group {
                        Text("Harga Maksimum")
                            .font(.headline)
                            .padding(.bottom, 10)
                        
                        HStack {
                            Text("Rp \(Int(filterModel.maxPrice))")
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
            
            // Apply Button
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
                        .fontWeight(.bold)
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

#Preview {
    Food()
}
