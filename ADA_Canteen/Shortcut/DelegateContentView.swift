//
//  DelegateContentView.swift
//  ADA Kantin
//
//  Created by Alvin Justine on 15/05/25.
//

import SwiftUI

struct DelegateContentView: View {
    var body: some View {
        ScrollView {
           VStack(alignment: .leading, spacing: 12) {
//               ForEach(TenantData.allTenants, id: \.id) { tenant in
//                   Text(tenant.name)
//                       .font(.headline)
//                       .padding(.top)

               ForEach(TenantData.allTenants, id: \.name) { tenant in
                   // You can create a custom view for food or display directly
                   ForEach(tenant.foodItems) { food in
                       Text(food.name)
                   }
               }
//                       VStack(alignment: .leading) {
//                           Text(food.name)
//                               .font(.subheadline)
//                           Text("Harga: Rp \(food.price)")
//                               .font(.caption)
//                           Text(food.foodDescription)
//                               .font(.caption2)
//                               .foregroundColor(.gray)
//                       }
//                       .padding()
//                       .background(Color(.systemGray6))
//                       .cornerRadius(8)
//                   }
//               }
           }
           .padding()
       }
       .frame(width: 320, height: 400)
    }
}

#Preview {
    DelegateContentView()
}


