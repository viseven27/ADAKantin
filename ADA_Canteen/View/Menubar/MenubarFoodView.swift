import SwiftUI

struct MenubarFoodView: View {
    @State private var searchText = ""
    @State private var isFilterViewPresented = false
    @State private var filterModel = FilterModel()

    let foodItems = DataHelper.loadTenants().flatMap(\.foodItems)

    var filteredFoodItems: [FoodItem] {
        foodItems.filter { food in
            let priceFilter = Double(food.price) <= filterModel.maxPrice
            let categoryFilter = filterModel.selectedFoodCategories.isEmpty ||
                food.tags.contains(where: { filterModel.selectedFoodCategories.contains($0) })
            let searchFilter = searchText.isEmpty ||
                food.name.localizedCaseInsensitiveContains(searchText)
            return priceFilter && categoryFilter && searchFilter
        }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                MenubarSearchView(searchText: $searchText) {
                    isFilterViewPresented = true
                }

                ScrollView {
                    MBGridView(foodItems: filteredFoodItems)
                }
                .sheet(isPresented: $isFilterViewPresented) {
                    FoodFilterView(filterModel: $filterModel)
                }
            }
        }
    }
}

