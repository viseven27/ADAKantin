import SwiftUI

struct TenantItem: Identifiable {
    let id: Int
    let name: String
    let image: String
    let logo: String
    let minPrice: Int
    let maxPrice: Int
    let tags: [String]
    let description: String
    let foodItems: [FoodItem]
    
    var priceRangeString: String {
        "\(minPrice.formattedWithSeparator) - \(maxPrice.formattedWithSeparator)"
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
        return TenantData.allTenants
    }
}

private func generateTenantFilterText(selectedCategories: Set<String>, minPrice: Int?, maxPrice: Int?) -> String {
    var parts = [String]()
    
    if !selectedCategories.isEmpty {
        let categoryNames = selectedCategories.map { $0.replacingOccurrences(of: "kategori.", with: "") }
        let categoriesText = categoryNames.count == 1 ?
            "kategori \(categoryNames[0])" :
            "kategori \(categoryNames.joined(separator: ", "))"
        parts.append(categoriesText)
    }
    
    if let min = minPrice, let max = maxPrice {
        parts.append("harga Rp\(min.formattedWithSeparator)-Rp\(max.formattedWithSeparator)")
    } else if let min = minPrice {
        parts.append("harga > Rp\(min.formattedWithSeparator)")
    } else if let max = maxPrice {
        parts.append("harga < Rp\(max.formattedWithSeparator)")
    }
    
    if parts.isEmpty {
        return "Menampilkan semua tenant"
    } else {
        return "Menampilkan tenant dengan \(parts.joined(separator: " dan "))"
    }
}

struct Tenant: View {
    @State private var searchText = ""
    @State private var isFilterViewPresented = false
    @State private var filterModel = FilterModel()
    
    let tenants = DataHelper.loadTenants()
    
    var filteredTenants: [TenantItem] {
        tenants.filter { tenant in
            let searchFilter = searchText.isEmpty ||
            tenant.name.localizedCaseInsensitiveContains(searchText)
            
            let categoryFilter = filterModel.selectedTenantCategories.isEmpty ||
            tenant.tags.contains { filterModel.selectedTenantCategories.contains($0) }
            
            let priceFilter: Bool
            if filterModel.minPriceFilter == nil && filterModel.maxPriceFilter == nil {
                priceFilter = true
            } else {
                let tenantMin = tenant.minPrice
                let tenantMax = tenant.maxPrice
                let filterMin = filterModel.minPriceFilter ?? Int.min
                let filterMax = filterModel.maxPriceFilter ?? Int.max
                
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
                        
                        TextField("Pingin makan di tenant yang mana?", text: $searchText)
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
                            .foregroundColor(Color(.gray))
                    }
                }
                .padding()
                
                VStack(alignment: .leading) {
                    Text("Tenant")
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                    
                    if !filterModel.selectedTenantCategories.isEmpty ||
                       filterModel.minPriceFilter != nil ||
                       filterModel.maxPriceFilter != nil {
                        Text(generateTenantFilterText(
                            selectedCategories: filterModel.selectedTenantCategories,
                            minPrice: filterModel.minPriceFilter,
                            maxPrice: filterModel.maxPriceFilter
                        ))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                    }
                    
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
                                            HStack {
                                                Text(tenant.name)
                                                    .font(.system(size: 16))
                                                    .fontWeight(.semibold)
                                            }
                                            
                                            Text(tenant.priceRangeString)
                                                .font(.system(size: 16))
                                                .fontWeight(.medium)
                                            
//                                            Text(tenant.description)
//                                                .font(.subheadline)
//                                                .foregroundColor(.gray)
//                                                .lineLimit(2)
//                                                .italic()
                                            
                                            HStack(spacing: 4) {
                                                ForEach(tenant.tags, id: \.self) { tag in
                                                    Image(tag)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 20, height: 20)
                                                }
                                                Spacer()
                                                
                                            }
                                        }
                                    }
                                    .padding(.horizontal)
                                    .padding(.vertical, 5)
                                    
//                                    .padding()
//                                    .background(Color.white)
//                                    .cornerRadius(12)
//                                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
//                                    .padding(.horizontal)
                                }
                                .buttonStyle(PlainButtonStyle())
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
//                        Text("Menu")
//                            .font(.title)
//                            .fontWeight(.semibold)
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                            .padding(.horizontal)
                        
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

// TenantFilterView
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


#Preview {
    Tenant()
}
