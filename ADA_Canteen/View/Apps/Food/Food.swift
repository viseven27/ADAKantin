import SwiftUI

struct FoodItem: Identifiable {
    let id = UUID()
    let name: String
    let price: Int
    let image: String
    let tags: [String]
//    Di sini yang mau kita ubah jadi text aja
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
            let priceFilter = Double(food.price) <= filterModel.maxPrice
            
            let categoryFilter = filterModel.selectedFoodCategories.isEmpty ||
            food.tags.contains { filterModel.selectedFoodCategories.contains($0) }
            
            let searchFilter = searchText.isEmpty ||
            food.name.localizedCaseInsensitiveContains(searchText)
        
            return priceFilter && categoryFilter && searchFilter
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0){
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white)
                            .frame(width: 25, height: 25)
                            .background(Color("aksen"))
                            .cornerRadius(5)
                        
                        TextField("Mau makan apa, nih??", text: $searchText)
                            .font(.system(size: 14, weight: .regular))
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
                
                VStack {
                    Text("Makanan")
                        .font(.system(size: 24))
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    if !filterModel.selectedFoodCategories.isEmpty || filterModel.maxPrice < 50000 {
                        Text(generateFilterText(
                            selectedCategories: filterModel.selectedFoodCategories,
                            maxPrice: filterModel.maxPrice
                        ))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                    }

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

#Preview {
    Food()
}
