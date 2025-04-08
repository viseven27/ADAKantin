//
//  FilterView.swift
//  ADA Kantin
//
//  Created by Daven Karim on 26/03/25.
//
// FilterModel.swift
import Foundation
import Observation

@Observable
class FilterModel {
    // For Food filtering
    var maxPrice: Double
    var selectedFoodCategories: Set<String>
    
    // For Tenant filtering
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
