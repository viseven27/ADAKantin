//
//  Tenant.swift
//  ADA_Canteen
//
//  Created by Daven Karim on 22/03/25.
//

import SwiftUI

struct TenantItem: Identifiable {
    let id: Int
    let name: String
    let image: String
    let minPrice: Int
    let maxPrice: Int
    let tags: [String]
    let description: String
    let foodItems: [FoodItem]
    
    var priceRangeString: String {
        "Rp \(minPrice.formattedWithSeparator) - \(maxPrice.formattedWithSeparator)"
    }
}

extension Int {
    var formattedWithSeparator: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}

final class DataHelper {
    static func loadTenants() -> [TenantItem] {
        return [
            TenantItem(id: 1,
                       name: "Soto Pak Gembul",
                       image: "sotopakgembul_img",
                       minPrice: 18000,
                       maxPrice: 30000,
                       tags: ["kategori.ayam", "kategori.sapi", "kategori.cabe", "kategori.sayur"],
                       description: "Soto lezat dengan kuah gurih dan daging empuk.",
                       foodItems: [
                        FoodItem(name: "Soto Ayam",
                                 price: 23000,
                                 image: "soto.ayam.pakgembul",
                                 tags: ["kategori.ayam", "kategori.sayur"],
                                 location: "Soto Pak Gembul",
                                 foodDescription: "Soto ayam lezat buatan Pak Gembul",
                                 tenantId: 1),
                        FoodItem(name: "Soto Ayam",
                                 price: 23000,
                                 image: "soto.ayam.pakgembul",
                                 tags: ["kategori.ayam", "kategori.sayur"],
                                 location: "Soto Pak Gembul",
                                 foodDescription: "Soto ayam lezat buatan Pak Gembul",
                                 tenantId: 1)
                       ]),
            TenantItem(id: 2,
                       name: "Kedai Aneka Rasa",
                       image: "kedaianekarasa_img",
                       minPrice: 15000,
                       maxPrice: 25000,
                       tags: ["kategori.ayam", "kategori.sapi", "kategori.ikan", "kategori.cabe", "kategori.sayur"],
                       description: "Menyajikan berbagai hidangan dengan cita rasa beragam.",
                       foodItems: [
                        FoodItem(name: "Ayam Bistik",
                                 price: 10000,
                                 image: "ayam.bistik",
                                 tags: ["kategori.ayam"],
                                 location: "Kedai Aneka Rasa",
                                 foodDescription: "Ayam bistik yang dagingnya empuk buatan Kedai Aneka Rasa",
                                 tenantId: 2)
                       ]),
            TenantItem(id: 3,
                       name: "Kedai 2 Nyonya",
                       image: "kedai2nyonya_img",
                       minPrice: 15000,
                       maxPrice: 25000,
                       tags: ["kategori.ayam", "kategori.sapi", "kategori.ikan", "kategori.cabe", "kategori.sayur"],
                       description: "Masakan rumahan ala nyonya, nikmat dan mengenyangkan.",
                       foodItems: [
                        FoodItem(name: "Nasi Bogana",
                                 price: 25000,
                                 image: "nasi.bogana",
                                 tags: ["kategori.ayam", "kategori.sayur"],
                                 location: "Kedai 2 Nyonya",
                                 foodDescription: "Nasi bogana yang lezat buatan Kedai 2 Nyonya",
                                 tenantId: 3)
                       ]),
            TenantItem(id: 4,
                       name: "Bebek Goreng Rinjani",
                       image: "bebekgorengrinjani_img",
                       minPrice: 23000,
                       maxPrice: 35000,
                       tags: ["kategori.ayam", "kategori.cabe"],
                       description: "Bebek goreng krispi dengan bumbu khas Rinjani.",
                       foodItems: [
                        FoodItem(name: "Bebek Goreng",
                                 price: 23000,
                                 image: "bebek.goreng.rinjani",
                                 tags: ["kategori.ayam", "kategori.cabe"],
                                 location: "Bebek Goreng Rinjani",
                                 foodDescription: "Bebek goreng krispi dengan bumbu khas Rinjani",
                                 tenantId: 4)
                       ]),
            TenantItem(id: 5,
                       name: "Kantin Kasturi",
                       image: "kantinkasturi_img",
                       minPrice: 15000,
                       maxPrice: 25000,
                       tags: ["kategori.ayam", "kategori.sapi", "kategori.ikan", "kategori.cabe", "kategori.sayur"],
                       description: "Hidangan sederhana dengan rasa yang memikat.",
                       foodItems: [
                        FoodItem(name: "Ayam Bistik",
                                 price: 7000,
                                 image: "ayam.bistik",
                                 tags: [ "kategori.ayam"],
                                 location: "Kantin Kasturi",
                                 foodDescription: "Potongan ayam empuk dipanggang atau digoreng dengan sempurna, disajikan dengan saus bistik khas yang manis-gurih, ditambah irisan bawang bombay dan paprika untuk cita rasa yang kaya. Cocok dinikmati dengan nasi hangat atau kentang tumbuk.",
                                 tenantId: 5),
                        FoodItem(name: "Cah Toge",
                                 price: 3000,
                                 image: "cah.toge",
                                 tags: ["kategori.sayur", "kategori.cabe"],
                                 location: "Kantin Kasturi",
                                 foodDescription: "Toge segar yang ditumis dengan bawang putih, cabai, dan bumbu rahasia kami. Hidangan sederhana namun penuh nutrisi dan rasa.",
                                 tenantId: 5),
                        FoodItem(name: "Ayam Teriyaki",
                                 price: 7000,
                                 image: "ayam.teriyaki",
                                 tags: ["kategori.ayam"],
                                 location: "Kantin Kasturi",
                                 foodDescription: "Ayam premium yang dimarinasi dengan saus teriyaki khas, dipanggang hingga kecokelatan dan disajikan dengan taburan wijen. Rasa manis-gurih yang seimbang.",
                                 tenantId: 5),
                        FoodItem(name: "Ikan Cabe Garam",
                                 price: 8000,
                                 image: "ikan.cabe.garam",
                                 tags: ["kategori.ikan", "kategori.cabe"],
                                 location: "Kantin Kasturi",
                                 foodDescription: "Ikan segar yang digoreng krispi lalu ditumis dengan cabai dan bawang putih. Pedas gurih yang menggugah selera.",
                                 tenantId: 5),
                        FoodItem(name: "Ayam Geprek",
                                 price: 17000,
                                 image: "ayam.geprek",
                                 tags: ["kategori.ayam", "kategori.cabe"],
                                 location: "Kantin Kasturi",
                                 foodDescription: "Ayam krispi ala geprek dengan sambal bawang yang pedasnya pas. Daging ayam yang juicy dengan lapisan tepung yang renyah.",
                                 tenantId: 5),
                        FoodItem(name: "Ayam Penyet",
                                 price: 17000,
                                 image: "ayam.penyet",
                                 tags: ["kategori.ayam", "kategori.cabe"],
                                 location: "Kantin Kasturi",
                                 foodDescription: "Ayam kampung yang dimasak dengan bumbu rempah khas, disajikan dengan sambal terasi yang pedas menggigit.",
                                 tenantId: 5),
                        FoodItem(name: "Sosis Oseng",
                                 price: 7000,
                                 image: "sosis.oseng",
                                 tags: ["kategori.sapi", "kategori.cabe"],
                                 location: "Kantin Kasturi",
                                 foodDescription: "Sosis premium yang dioseng dengan bawang bombay, cabai, dan bumbu spesial. Cocok untuk teman nasi hangat.",
                                 tenantId: 5),
                        FoodItem(name: "Tempe Orek",
                                 price: 3500,
                                 image: "tempe.orek",
                                 tags: ["kategori.sayur"],
                                 location: "Kantin Kasturi",
                                 foodDescription: "Tempe yang diiris tipis dan digoreng kering dengan bumbu manis pedas. Kriuk-kriuk yang bikin ketagihan.",
                                 tenantId: 5),
                        FoodItem(name: "Sapi Lada Hitam",
                                 price: 8000,
                                 image: "sapi.lada.hitam",
                                 tags: ["kategori.sapi", "kategori.cabe"],
                                 location: "Kantin Kasturi",
                                 foodDescription: "Daging sapi pilihan yang ditumis dengan lada hitam, bawang bombay, dan paprika. Gurih dan sedikit pedas.",
                                 tenantId: 5),
                        FoodItem(name: "Telur Dadar",
                                 price: 3000,
                                 image: "telur.dadar",
                                 tags: ["kategori.sayur"],
                                 location: "Kantin Kasturi",
                                 foodDescription: "Telur dadar tebal dengan isian daun bawang dan bumbu rahasia. Sederhana tapi selalu memuaskan.",
                                 tenantId: 5)
                       ]),
            TenantItem(id: 6,
                       name: "La Ding",
                       image: "lading_img",
                       minPrice: 18000,
                       maxPrice: 30000,
                       tags: ["kategori.ayam", "kategori.sapi", "kategori.ikan", "kategori.cabe", "kategori.sayur"],
                       description: "Menjual soto dan siomay enak, cocok untuk makan siang.",
                       foodItems: [
                        FoodItem(name: "Telur Dadar La ding",
                                 price: 5000,
                                 image: "telur.dadar",
                                 tags: ["kategori.sayur"],
                                 location: "La Ding",
                                 foodDescription: "Telur dadar renyah dan lezat buatan La Ding.",
                                 tenantId: 6),
                        FoodItem(name: "Gado-Gado la ding",
                                 price: 18000,
                                 image: "gado.gado",
                                 tags: ["kategori.sayur"],
                                 location: "La Ding",
                                 foodDescription: "Campuran sayuran segar dengan bumbu kacang khas yang gurih. Disajikan dengan kerupuk dan telur rebus.",
                                 tenantId: 6)
                       ]),
            TenantItem(id: 7,
                       name: "Kedai Laris",
                       image: "kedailaris_img",
                       minPrice: 18000,
                       maxPrice: 35000,
                       tags: ["kategori.ayam", "kategori.sapi", "kategori.ikan", "kategori.cabe", "kategori.sayur"],
                       description: "Pilihan menu yang selalu laris dan favorit pelanggan.",
                       foodItems: [
                        FoodItem(name: "Ayam Bistik",
                                 price: 8500,
                                 image: "ayam.bistik",
                                 tags: [ "kategori.ayam"],
                                 location: "Kedai Laris",
                                 foodDescription: "Ayam bistik yang dagingnya berkualitas dan segar buatan Kedai Laris.",
                                 tenantId: 7)
                       ]),
            TenantItem(id: 8,
                       name: "Kedai Khas Nusantara",
                       image: "kedaikhasnusantara_img",
                       minPrice: 18000,
                       maxPrice: 25000,
                       tags: ["kategori.ayam", "kategori.sapi", "kategori.ikan", "kategori.cabe", "kategori.sayur"],
                       description: "Menyajikan kuliner tradisional dari berbagai daerah di Indonesia.",
                       foodItems: [
                        FoodItem(name: "Ayam Bistik",
                                 price: 5000,
                                 image: "ayam.bistik",
                                 tags: [ "kategori.ayam"],
                                 location: "Kedai Khas Nusantara",
                                 foodDescription: "Ayam bistik yang dagingnya berkualitas dan segar buatan Kedai Khas Nusantara.",
                                 tenantId: 8)
                       ]),
            TenantItem(id: 9,
                       name: "Dapoer Cowek",
                       image: "dapoercowek_img",
                       minPrice: 15000,
                       maxPrice: 30000,
                       tags: ["kategori.ayam", "kategori.sapi", "kategori.ikan", "kategori.cabe", "kategori.sayur"],
                       description: "Masakan rumahan autentik dengan sentuhan bumbu cowek khas.",
                       foodItems: [
                        FoodItem(name: "Ayam Bistik",
                                 price: 7000,
                                 image: "ayam.bistik",
                                 tags: [ "kategori.ayam"],
                                 location: "Dapoer Cowek",
                                 foodDescription: "Ayam bistik yang dagingnya berkualitas dan segar buatan Dapoer Cowek.",
                                 tenantId: 9)
                       ]),
            TenantItem(id: 10,
                       name: "Mama Djempol",
                       image: "mamadjempol_img",
                       minPrice: 18000,
                       maxPrice: 30000,
                       tags: ["kategori.ayam", "kategori.sapi", "kategori.ikan", "kategori.cabe", "kategori.sayur"],
                       description: "Masakan ala mama yang bikin jempol naik!",
                       foodItems: [
                        FoodItem(name: "Ayam Bistik",
                                 price: 11000,
                                 image: "ayam.bistik",
                                 tags: [ "kategori.ayam"],
                                 location: "Mama Djempol",
                                 foodDescription: "Ayam bistik yang dagingnya berkualitas dan segar buatan Mama Djempol.",
                                 tenantId: 10)
                       ]),
            TenantItem(id: 11,
                       name: "AHZA",
                       image: "ahza_img",
                       minPrice: 18000,
                       maxPrice: 30000,
                       tags: ["kategori.ayam", "kategori.sapi", "kategori.ikan", "kategori.cabe", "kategori.sayur"],
                       description: "Hidangan spesial dengan cita rasa unik.",
                       foodItems: [
                        FoodItem(name: "Ayam Bistik",
                                 price: 7000,
                                 image: "ayam.bistik",
                                 tags: [ "kategori.ayam"],
                                 location: "AHZA",
                                 foodDescription: "Ayam bistik yang dagingnya berkualitas dan segar buatan AHZA.",
                                 tenantId: 11)
                       ]),
            TenantItem(id: 12,
                       name: "Mustafa Minang",
                       image: "mustafaminang_img",
                       minPrice: 18000,
                       maxPrice: 30000,
                       tags: ["kategori.ayam", "kategori.sapi", "kategori.ikan", "kategori.cabe", "kategori.sayur"],
                       description: "Masakan Minang otentik, pedas dan menggugah selera.",
                       foodItems: [
                        FoodItem(name: "Ayam Bistik",
                                 price: 7000,
                                 image: "ayam.bistik",
                                 tags: [ "kategori.ayam"],
                                 location: "Mustafa Minang",
                                 foodDescription: "Ayan bistik yang dagingnya berkualitas dan segar buatan Mustafa Minang.",
                                 tenantId: 12)
                       ]),
            TenantItem(id: 13,
                       name: "Bakso Jos",
                       image: "baksojos_img",
                       minPrice: 18000,
                       maxPrice: 30000,
                       tags: ["kategori.ayam", "kategori.ikan", "kategori.cabe", "kategori.sayur"],
                       description: "Bakso kenyal dengan kuah kaldu mantap.",
                       foodItems: [
                        FoodItem(name: "Bakso Urat Komplit",
                                 price: 25000,
                                 image: "bakso.urat.komplit.baksojos",
                                 tags: [ "kategori.sapi", "kategori.sayur"],
                                 location: "Bakso Jos",
                                 foodDescription: "Bake urat dengan daging sapi dan sayur buatan Bakso Jos.",
                                 tenantId: 13)
                       ]),
        ]
    }
}

struct Tenant: View {
    @State private var searchText = ""
    @State private var isFilterViewPresented = false
    @State private var filterModel = FilterModel()
    
    let tenants = DataHelper.loadTenants()
    
    var filteredTenants: [TenantItem] {
        tenants.filter { tenant in
            // Search filter
            let searchFilter = searchText.isEmpty ||
            tenant.name.localizedCaseInsensitiveContains(searchText)
            
            // Category filter
            let categoryFilter = filterModel.selectedTenantCategories.isEmpty ||
            tenant.tags.contains { filterModel.selectedTenantCategories.contains($0) }
            
            // Price range filter
            let priceFilter: Bool
            if filterModel.minPriceFilter == nil && filterModel.maxPriceFilter == nil {
                priceFilter = true
            } else {
                let tenantMin = tenant.minPrice
                let tenantMax = tenant.maxPrice
                let filterMin = filterModel.minPriceFilter ?? Int.min
                let filterMax = filterModel.maxPriceFilter ?? Int.max
                
                // Check if tenant's range overlaps with filter range
                //                priceFilter =
                priceFilter = (tenantMax >= filterMin) && (tenantMin <= filterMax)
            }
            
            return searchFilter && categoryFilter && priceFilter
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
                VStack(alignment: .leading) {
                    Text("Tenants")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    ScrollView {
                        VStack(spacing: 15) {
                            ForEach(filteredTenants) { tenant in
                                NavigationLink(destination: TenantDetailView(tenant: tenant)) {
                                    HStack(alignment: .top, spacing: 15) {
                                        Image(tenant.image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 80, height: 80)
                                            .cornerRadius(10)
                                            .clipped()
                                        
                                        VStack(alignment: .leading, spacing: 5) {
                                            Text(tenant.name)
                                                .font(.headline)
                                                .foregroundColor(.black)
                                            
                                            Text(tenant.description)
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                                .lineLimit(2)
                                                .italic()
                                            
                                            HStack(spacing: 4) {
                                                ForEach(tenant.tags, id: \.self) { tag in
                                                    Image(tag)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 20, height: 20)
                                                }
                                                Spacer()
                                                Text(tenant.priceRangeString)
                                                    .font(.caption)
                                                    .fontWeight(.bold)
                                            }
                                        }
                                    }
                                    .padding(.horizontal)
                                    .padding(.vertical, 5)
                                }
                                .buttonStyle(PlainButtonStyle())
                                
                                if tenant.id != filteredTenants.last?.id {
                                    Divider()
                                        .padding(.horizontal)
                                }
                            }
                        }
                        .padding(.bottom, 20)
                    }
                }
            }
            .sheet(isPresented: $isFilterViewPresented) {
                TenantFilterView(filterModel: $filterModel)
            }
        }
    }
}


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
                .padding(.horizontal)
                .padding(.top)
                
                ScrollView {
                    // Background Image with Logo Overlay
                    ZStack(alignment: .bottom) {
                        // Background Image (unchanged)
                        Image(tenant.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 130)
                            .clipped()
                        
                        // Logo and Info in HStack
                        HStack(alignment: .bottom, spacing: 20) {
                            // Logo (now aligned to bottom left)
                            Image(systemName: "fork.knife.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .foregroundColor(.white)
                                .background(Color.gray.opacity(0.7))
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                                .shadow(radius: 5)
                                .offset(y: 70) // Adjusted offset
                            
                            // Tenant Info VStack (right side of logo)
                            VStack(alignment: .leading, spacing: 8) {
                                // Tenant Name
                                Text(tenant.name)
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                                
                                // Price Range
                                Text(tenant.priceRangeString)
                                    .font(.system(size: 12))
                                    .foregroundColor(.secondary)
                                    .fontWeight(.semibold)
                                
                                // Deskripsi Tenant
                                Text(tenant.description)
                                    .font(.system(size: 12))
                                    .foregroundColor(.secondary)
                                    .italic()
                                    .fixedSize(horizontal: false, vertical: true)
                                // Tag Kategori
                                HStack(spacing: 12) {
                                    ForEach(tenant.tags, id: \.self) { tag in
                                        Image(tag)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 30, height: 30)
                                    }
                                }
                                //                                .padding(.top, 8)
                            }
                            //                            .padding(.leading, 5)
                            //                            .padding(.bottom, 20)
                            .offset(y: 135)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    }
                    .padding(.bottom, 100) // Adjusted padding
                    
                    // Menu Section (unchanged)
                    VStack {
                        Text("Menu")
                            .font(.title)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        
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
                    .padding(.top, 8)
                    .sheet(isPresented: $isFilterViewPresented) {
                        FoodFilterView(filterModel: $filterModel)
                    }
                }
            }
            .navigationTitle("Tenant Details")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// TenantFilterView.swift
struct TenantFilterView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var filterModel: FilterModel
    
    let categories = ["kategori.ayam", "kategori.sayur", "kategori.ikan", "kategori.sapi", "kategori.cabe"]
    let priceSteps = Array(stride(from: 0, through: 100000, by: 5000))
    
    var body: some View {
        VStack {
            HStack {
                Text("Filter Tenant")
                    .font(.largeTitle)
                    .fontWeight(.bold)
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
                            .font(.headline)
                        
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10) {
                            ForEach(categories, id: \.self) { category in
                                Button(action: {
                                    filterModel.toggleTenantCategory(category)
                                }) {
                                    HStack {
                                        Image(category)
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                        Text(category.replacingOccurrences(of: "kategori.", with: ""))
                                            .font(.subheadline)
                                    }
                                    //                                    .padding(8)
                                    .frame(width: 115, height: 45)
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
                        Text("Range Harga (Rp)")
                            .font(.headline)
                        
                        VStack(alignment: .leading, spacing: 20) {
                            // Slider untuk Harga Minimum
                            VStack(alignment: .leading) {
                                Text("Minimum: Rp \(filterModel.minPriceFilter?.formattedWithSeparator ?? "0")")
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
                            
                            // Slider untuk Harga Maksimum
                            VStack(alignment: .leading) {
                                Text("Maksimum: Rp \(filterModel.maxPriceFilter?.formattedWithSeparator ?? "100.000")")
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
    Tenant()
}
