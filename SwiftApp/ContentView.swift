//
//  ContentView.swift
//  SwiftApp
//
//  Created by Adrien CHENU on 1/19/24.
//

import SwiftUI

enum LooterFeature {
    case loot
    case wishList
    case profile
}

class Inventory : ObservableObject {
    @Published var loot = [
        LootItem(name: "Magic Wand", type: .magic, rarity: .common, attackStrength: 5, game: randomGame()),
        LootItem(name: "Steel Armor", type: .poison, rarity: .uncommon, attackStrength: nil, game: randomGame()),
        LootItem(name: "Fire Sword", type: .thunder, rarity: .rare, attackStrength: 15, game: randomGame()),
        LootItem(name: "Health Potion", type: .ice, rarity: .common, attackStrength: nil, game: randomGame()),
        LootItem(name: "Amulet of Power", type: .unknown, rarity: .epic, attackStrength: 30, game: randomGame()),
        LootItem(name: "Swift Boots", type: .wind, rarity: .uncommon, attackStrength: nil, game: randomGame()),
    ]
    
    func addItem(item: LootItem) {
        loot.append(item)
    }
    
    func updateItem(item: LootItem) {
        print(item)
        if let index = loot.firstIndex(where: { $0.name == item.name }) {
            print(loot[index])
            loot[index].name = item.name
            loot[index].rarity = item.rarity
            loot[index].quantity = item.quantity
            loot[index].type = item.type
            loot[index].game = item.game
            loot[index].attackStrength = item.attackStrength
        }
    }
}

struct ContentView: View {
    @State private var selectedFeature: LooterFeature = .loot
    
    var body: some View {
        TabView(selection: $selectedFeature) {
            LootView()
                .tabItem {
                    Label("Loot", systemImage: "gym.bag.fill")
                }
                .tag(LooterFeature.loot)
            WishListView()
                .tabItem {
                    Label("Wishlist", systemImage: "wand.and.stars")
                }
                .tag(LooterFeature.wishList)
            ProfileView()
                .tabItem {
                    Label("Profil", systemImage: "person.fill")
                }
                .tag(LooterFeature.profile)
        }
    }
}	

/*
#Preview {
    ContentView()
}
*/
