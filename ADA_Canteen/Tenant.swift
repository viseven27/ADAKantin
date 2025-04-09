import SwiftUI

struct TenantItem: Identifiable {
    let id = UUID()
    let name: String
    let image: String
    let minPrice: Int
    let maxPrice: Int
    let tags: [String]
    let description: String
    
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

struct Tenant: View {
    @State private var searchText = ""
    @State private var isFilterViewPresented = false
    @State private var filterModel = FilterModel()
    
    let tenants = [
        TenantItem(name: "Soto Pak Gembul",
                   image: "sotopakgembul_img",
                   minPrice: 18000,
                   maxPrice: 30000,
                   tags: ["kategori.ayam", "kategori.sapi", "kategori.cabe", "kategori.sayur"],
                   description: "Soto lezat dengan kuah gurih dan daging empuk."),
        TenantItem(name: "Kedai Aneka Rasa",
                   image: "kedaianekarasa_img",
                   minPrice: 15000,
                   maxPrice: 25000,
                   tags: ["kategori.ayam", "kategori.sapi", "kategori.ikan", "kategori.cabe", "kategori.sayur"],
                   description: "Menyajikan berbagai hidangan dengan cita rasa beragam."),
        TenantItem(name: "Kedai 2 Nyonya",
                   image: "kedai2nyonya_img",
                   minPrice: 15000,
                   maxPrice: 25000,
                   tags: ["kategori.ayam", "kategori.sapi", "kategori.ikan", "kategori.cabe", "kategori.sayur"],
                   description: "Masakan rumahan ala nyonya, nikmat dan mengenyangkan."),
        TenantItem(name: "Bebek Goreng Rinjani",
                   image: "bebekgorengrinjani_img",
                   minPrice: 23000,
                   maxPrice: 35000,
                   tags: ["kategori.ayam", "kategori.cabe"],
                   description: "Bebek goreng krispi dengan bumbu khas Rinjani."),
        TenantItem(name: "Kantin Kasturi",
                   image: "kantinkasturi_img",
                   minPrice: 15000,
                   maxPrice: 25000,
                   tags: ["kategori.ayam", "kategori.sapi", "kategori.ikan", "kategori.cabe", "kategori.sayur"],
                   description: "Hidangan sederhana dengan rasa yang memikat."),
        TenantItem(name: "La Ding",
                   image: "lading_img",
                   minPrice: 18000,
                   maxPrice: 30000,
                   tags: ["kategori.ayam", "kategori.sapi", "kategori.ikan", "kategori.cabe", "kategori.sayur"],
                   description: "Menjual soto dan siomay enak, cocok untuk makan siang."),
        TenantItem(name: "Kedai Laris",
                   image: "kedailaris_img",
                   minPrice: 18000,
                   maxPrice: 35000,
                   tags: ["kategori.ayam", "kategori.sapi", "kategori.ikan", "kategori.cabe", "kategori.sayur"],
                   description: "Pilihan menu yang selalu laris dan favorit pelanggan."),
        TenantItem(name: "Kedai Khas Nusantara",
                   image: "kedaikhasnusantara_img",
                   minPrice: 18000,
                   maxPrice: 25000,
                   tags: ["kategori.ayam", "kategori.sapi", "kategori.ikan", "kategori.cabe", "kategori.sayur"],
                   description: "Menyajikan kuliner tradisional dari berbagai daerah di Indonesia."),
        TenantItem(name: "Dapoer Cowek",
                   image: "dapoercowek_img",
                   minPrice: 15000,
                   maxPrice: 30000,
                   tags: ["kategori.ayam", "kategori.sapi", "kategori.ikan", "kategori.cabe", "kategori.sayur"],
                   description: "Masakan rumahan autentik dengan sentuhan bumbu cowek khas."),
        TenantItem(name: "Mama Djempol",
                   image: "mamadjempol_img",
                   minPrice: 18000,
                   maxPrice: 30000,
                   tags: ["kategori.ayam", "kategori.sapi", "kategori.ikan", "kategori.cabe", "kategori.sayur"],
                   description: "Masakan ala mama yang bikin jempol naik!"),
        TenantItem(name: "AHZA",
                   image: "ahza_img",
                   minPrice: 18000,
                   maxPrice: 30000,
                   tags: ["kategori.ayam", "kategori.sapi", "kategori.ikan", "kategori.cabe", "kategori.sayur"],
                   description: "Hidangan spesial dengan cita rasa unik."),
        TenantItem(name: "Mustafa Minang",
                   image: "mustafaminang_img",
                   minPrice: 18000,
                   maxPrice: 30000,
                   tags: ["kategori.ayam", "kategori.sapi", "kategori.ikan", "kategori.cabe", "kategori.sayur"],
                   description: "Masakan Minang otentik, pedas dan menggugah selera."),
        TenantItem(name: "Bakso Jos",
                   image: "baksojos_img",
                   minPrice: 18000,
                   maxPrice: 30000,
                   tags: ["kategori.ayam", "kategori.ikan", "kategori.cabe", "kategori.sayur"],
                   description: "Bakso kenyal dengan kuah kaldu mantap.")
    ]
    
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
                        // Background Image
                        Image(tenant.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 180)
                            .clipped()
                        
                        // Placeholder Logo Tenant yang Bulat
                        VStack {
                            Image(systemName: "fork.knife.circle.fill") // Placeholder icon
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .foregroundColor(.white)
                                .background(Color.gray.opacity(0.7))
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                                .shadow(radius: 5)
                                .offset(y: 50) // Yang overlap sama background setengahnya doang -> pake sumbu y aturnya
                        }
                    }
                    .padding(.bottom, 30) // Space for the logo
                    
                    // Tenant Name
                    Text(tenant.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top, 30)
                    
                    // Price Range
//                    Text("Rp \(tenant.priceRange)")
//                        .font(.subheadline)
//                        .foregroundColor(.secondary)
//                        .fontWeight(.semibold)
                    
                    // Deskripsi Tenant
                    Text(tenant.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.top, 5)
                        .italic()
                    
                    // Tag Kategori (as icons)
                    HStack(spacing: 12) {
                        ForEach(tenant.tags, id: \.self) { tag in
                            Image(tag)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                        }
                    }
                    .padding(.top, 12)
                    
                    Spacer()
                    
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
                    // Price Range Filter
                    Group {
                        Text("Range Harga (Rp)")
                            .font(.headline)
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Minimum:")
                                Picker("Minimum Price", selection: Binding(
                                    get: { filterModel.minPriceFilter ?? 0 },
                                    set: { filterModel.minPriceFilter = $0 == 0 ? nil : $0 }
                                )) {
                                    ForEach(priceSteps, id: \.self) { price in
                                        Text("\(price.formattedWithSeparator)").tag(price)
                                    }
                                }
                                .pickerStyle(.menu)
                            }
                            
                            HStack {
                                Text("Maksimum:")
                                Picker("Maximum Price", selection: Binding(
                                    get: { filterModel.maxPriceFilter ?? 100000 },
                                    set: { filterModel.maxPriceFilter = $0 == 100000 ? nil : $0 }
                                )) {
                                    ForEach(priceSteps, id: \.self) { price in
                                        Text("\(price.formattedWithSeparator)").tag(price)
                                    }
                                }
                                .pickerStyle(.menu)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
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
                                            .frame(width: 20, height: 20)
                                        Text(category.replacingOccurrences(of: "kategori.", with: ""))
                                            .font(.caption)
                                    }
                                    .padding(8)
                                    .frame(maxWidth: .infinity)
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
                        .padding(.horizontal)
                    }
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
