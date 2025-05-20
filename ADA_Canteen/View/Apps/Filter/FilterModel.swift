import Foundation
import Observation

@Observable
class FilterModel {
    var maxPrice: Double
    var selectedFoodCategories: Set<String>
    
    var minPriceFilter: Int?
    var maxPriceFilter: Int?
    var selectedTenantCategories: Set<String>
    
    init(
        maxPrice: Double = 50000,
        selectedFoodCategories: Set<String> = [],
        minPriceFilter: Int? = nil,
        maxPriceFilter: Int? = nil,
        selectedTenantCategories: Set<String> = []
    ) {
        self.maxPrice = maxPrice
        self.selectedFoodCategories = selectedFoodCategories
        self.minPriceFilter = minPriceFilter
        self.maxPriceFilter = maxPriceFilter
        self.selectedTenantCategories = selectedTenantCategories
    }
    
    func toggleFoodCategory(_ category: String) {
        selectedFoodCategories.toggle(category)
    }
    
    func toggleTenantCategory(_ category: String) {
        selectedTenantCategories.toggle(category)
    }
    
    func reset() {
        maxPrice = 50000
        selectedFoodCategories = []
        minPriceFilter = nil
        maxPriceFilter = nil
        selectedTenantCategories = []
    }
}

extension Set {
    mutating func toggle(_ member: Element) {
        if contains(member) {
            remove(member)
        } else {
            insert(member)
        }
    }
}

public func generateFilterText(selectedCategories: Set<String>, maxPrice: Double) -> String {
    var parts = [String]()
    
    if !selectedCategories.isEmpty {
        let categoryNames = selectedCategories.map { $0.replacingOccurrences(of: "kategori.", with: "") }
        let categoriesText = categoryNames.count == 1 ?
            "kategori \(categoryNames[0])" :
            "kategori \(categoryNames.joined(separator: ", "))"
        parts.append(categoriesText)

    }
    
    if maxPrice < 50000 {
        parts.append("harga < Rp\(Int(maxPrice).formattedWithSeparator)")
    }
    
    if parts.isEmpty {
        return "Menampilkan semua makanan"
    } else {
        return "Menampilkan makanan dengan \(parts.joined(separator: " dan "))"
    }
}

