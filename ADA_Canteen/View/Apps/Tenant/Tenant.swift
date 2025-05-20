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
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                
                VStack(alignment: .leading) {
                    Text("Tenants")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    // Di dalam VStack utama, setelah Text("Tenants")
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

#Preview {
    Tenant()
}
