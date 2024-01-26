//
//  LootView.swift
//  SwiftApp
//
//  Created by Adrien CHENU on 1/26/24.
//

import SwiftUI

struct LootView: View {
    @StateObject var inventory = Inventory()
    @AppStorage("isOnboardingDone") var isOnboardingDone: Bool = false

    @State var showAddItemView = false
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("INFORMATIONS")) {
                    ForEach(inventory.loot, id: \.self) { loot in
                        NavigationLink {
                            LootDetailView(item: loot)
                                .environmentObject(inventory)
                        } label: {
                            LootRow(item: loot)
                        }
                    }
                    .onDelete { indexSet in
                        inventory.loot.remove(atOffsets: indexSet)
                    }
                }

                Section(header: Text("VOS JEUX")) {
                    NavigationStack {
                        HStack {
                            ForEach(availableGames) { item in
                                GameCard(game: item)
                            }
                        }
                    }
                }
            }
            .sheet(isPresented: $showAddItemView, content: {
                AddItemView()
                    .environmentObject(inventory)
            })
            .navigationBarTitle("Inventaire")
            .toolbar(content: {
                ToolbarItem(placement: ToolbarItemPlacement.automatic) {
                    Button(action: {
                        showAddItemView.toggle()
                    }, label: {
                        HStack {
                            Image(systemName: "plus.app.fill")
                            Text("Ajouter")
                        }
                    })
                }
                ToolbarItem {
                    Button(action: {
                        isOnboardingDone = false
                    }, label: {
                        Image(systemName: "xmark.square.fill")
                    })
                }
            })
            .listStyle(InsetListStyle())
        }
    }
}

/*
#Preview {
    LootView()
}
*/
