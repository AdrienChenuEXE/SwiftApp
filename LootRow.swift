//
//  LootRow.swift
//  SwiftApp
//
//  Created by Adrien CHENU on 1/23/24.
//

import SwiftUI

struct LootRow: View {
    @State var item : LootItem
    
    var body: some View {
        VStack(){
            HStack(){
                Circle()
                    .fill(item.rarity.getColor())
                    .frame(width: 15, height: 15)
                Text(item.name)
                    .font(.headline)
                Spacer()
                Text(item.type.getLogo())
            }
            HStack(){
                Text("Quantité : \(item.quantity)")
                Spacer()
            }
        }
    }
}

/*
#Preview {
    LootRow(
        item : items.randomElement()!
    )
}
*/
