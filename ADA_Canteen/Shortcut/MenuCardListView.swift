//
//  MenuCardListView.swift
//  ADA Kantin
//
//  Created by Alvin Justine on 15/05/25.
//


import SwiftUI

struct MenuCardListView: View {
    let foodItems = TenantData.allTenants.first?.foodItems ?? []
    
    var body: some View{
        ScrollView{
            VStack(alignment: .leading, spacing: 12){
                ForEach(foodItems, id: \.name){item in
                    DelegateFoodCard(item: item)
                }
            }
            .padding()
        }
        .frame(width: 320, height: 400)
    }
}
