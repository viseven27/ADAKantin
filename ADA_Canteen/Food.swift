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
}

struct Food: View {
    @State private var searchText = ""
    @State private var isFilterViewPresented = false
    @State private var filterModel = FilterModel()
    
    let foodItems = [
        FoodItem(name: "Ayam Bistik", price: 5000, image: "ayam.bistik", tags: [ "kategori.ayam"], location: "Kantin Kasturi"),
        FoodItem(name: "Cah Toge", price: 5000, image: "cah.toge", tags: ["kategori.sayur", "kategori.cabe"], location: "Kantin Kasturi"),
        FoodItem(name: "Ayam Teriyaki", price: 5000, image: "ayam.teriyaki", tags: ["kategori.ayam"], location: "Kantin Kasturi"),
        FoodItem(name: "Ikan Cabe Garam", price: 5000, image: "ikan.cabe.garam", tags: ["kategori.ikan", "kategori.cabe"], location: "Kantin Kasturi"),
        FoodItem(name: "Ayam Geprek", price: 5000, image: "ayam.geprek", tags: ["kategori.ayam", "kategori.cabe"], location: "Kantin Kasturi"),
        FoodItem(name: "Ayam Penyet", price: 5000, image: "ayam.penyet", tags: ["kategori.ayam", "kategori.cabe"], location: "Kantin Kasturi"),
        FoodItem(name: "Sosis Oseng", price: 4500, image: "sosis.oseng", tags: ["kategori.sapi", "kategori.cabe"], location: "Kantin Kasturi"),
        FoodItem(name: "Tempe Orek", price: 3500, image: "tempe.orek", tags: ["kategori.sayur"], location: "Kantin Kasturi"),
        FoodItem(name: "Sapi Lada Hitam", price: 8000, image: "sapi.lada.hitam", tags: ["kategori.sapi", "kategori.cabe"], location: "Kantin Kasturi"),
        FoodItem(name: "Telur Dadar", price: 3000, image: "telur.dadar", tags: ["kategori.sayur"], location: "Kantin Kasturi"),
        FoodItem(name: "Gado-Gado", price: 6000, image: "gado.gado", tags: ["kategori.sayur"], location: "Kantin Kasturi")
    ]
    
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
    
    let tenant = TenantItem(
        name: "Kantin Kasturi",
        image: "kantinkasturi_img",
        minPrice: 15000,
        maxPrice: 25000,
        tags: ["kategori.ayam", "kategori.sapi", "kategori.ikan", "kategori.cabe", "kategori.sayur"],
        description: "Hidangan sederhana dengan rasa yang memikat"
    )
    
    // Generate food description based on food name
    var foodDescription: String {
        switch foodItem.name {
        case "Ayam Bistik":
            return "Potongan ayam empuk dipanggang atau digoreng dengan sempurna, disajikan dengan saus bistik khas yang manis-gurih, ditambah irisan bawang bombay dan paprika untuk cita rasa yang kaya. Cocok dinikmati dengan nasi hangat atau kentang tumbuk."
        case "Cah Toge":
            return "Toge segar yang ditumis dengan bawang putih, cabai, dan bumbu rahasia kami. Hidangan sederhana namun penuh nutrisi dan rasa."
        case "Ayam Teriyaki":
            return "Ayam premium yang dimarinasi dengan saus teriyaki khas, dipanggang hingga kecokelatan dan disajikan dengan taburan wijen. Rasa manis-gurih yang seimbang."
        case "Ikan Cabe Garam":
            return "Ikan segar yang digoreng krispi lalu ditumis dengan cabai dan bawang putih. Pedas gurih yang menggugah selera."
        case "Ayam Geprek":
            return "Ayam krispi ala geprek dengan sambal bawang yang pedasnya pas. Daging ayam yang juicy dengan lapisan tepung yang renyah."
        case "Ayam Penyet":
            return "Ayam kampung yang dimasak dengan bumbu rempah khas, disajikan dengan sambal terasi yang pedas menggigit."
        case "Sosis Oseng":
            return "Sosis premium yang dioseng dengan bawang bombay, cabai, dan bumbu spesial. Cocok untuk teman nasi hangat."
        case "Tempe Orek":
            return "Tempe yang diiris tipis dan digoreng kering dengan bumbu manis pedas. Kriuk-kriuk yang bikin ketagihan."
        case "Sapi Lada Hitam":
            return "Daging sapi pilihan yang ditumis dengan lada hitam, bawang bombay, dan paprika. Gurih dan sedikit pedas."
        case "Telur Dadar":
            return "Telur dadar tebal dengan isian daun bawang dan bumbu rahasia. Sederhana tapi selalu memuaskan."
        case "Gado-Gado":
            return "Campuran sayuran segar dengan bumbu kacang khas yang gurih. Disajikan dengan kerupuk dan telur rebus."
        default:
            return "Hidangan lezat dengan cita rasa khas yang menggugah selera."
        }
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
                        Text(foodItem.name)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("Rp \(foodItem.price)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .fontWeight(.semibold)
                        
                        // Tag Kategori
                        HStack(spacing: 4) {
                            ForEach(foodItem.tags, id: \.self) { tag in
                                Image(tag)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .padding(.top, 5)
                                    .padding(.bottom, 9)
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
                            
                            Text(foodDescription)
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
                            .background(Color("aksen20persen"))
                            .cornerRadius(10)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.horizontal)
                        
                        Spacer()
                    }
                    .padding(.bottom, 20)
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
    
    let categories = ["kategori.ayam", "kategori.sayur", "kategori.ikan", "kategori.sapi", "kategori.cabe"]
    
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
                    // Price Filter
                    Group {
                        Text("Harga Maksimum")
                            .font(.headline)
                        
                        HStack {
                            Text("Rp \(Int(filterModel.maxPrice))")
                            Spacer()
                        }
                        
                        Slider(
                            value: $filterModel.maxPrice,
                            in: 0...10000,
                            step: 500
                        )
                        .accentColor(Color("aksen"))
                    }
                    .padding(.horizontal)
                    
                    // Category Filter
                    Group {
                        Text("Kategori")
                            .font(.headline)
                            .padding(.vertical, 10)
                        
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
                }
            }
            
            // Apply Button
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
            .padding()
        }
    }
}

#Preview {
    Food()
}
