//
//  ContentView.swift
//  SwiftApp
//
//  Created by Adrien CHENU on 1/19/24.
//

import SwiftUI

class Inventory : ObservableObject {
    @Published var loot = items
    
    func addItem(item: LootItem) {
        loot.append(item)
    }
}

struct ContentView: View {
    @StateObject var inventory = Inventory()
    
    @State var showAddItemView = false
    
    var body: some View {
        NavigationStack {
            List {
                Section{
                    ForEach(inventory.loot, id: \.self) { item in
                        NavigationLink {
                            LootDetailView(item: item)
                        } label: {
                            LootRow(item: item)
                        }
                    }
                }header: {
                    Text("INFORMATIONS")
                }
                
                Section{
                    NavigationStack{
                            HStack{
                                ForEach(availableGames){ item in
                                    GameCard(game: item)
                            }
                        }
                    }
                }header: {
                    Text("VOS JEUX")
                }
            }
            .sheet(isPresented: $showAddItemView, content: {
                AddItemView()
                    .environmentObject(inventory)
            })
            .navigationBarTitle("Inventaire") // Notre titre de page, choisissez le titre que vous voulez
            .toolbar(content: { // La barre d'outil de notre page
                ToolbarItem(placement: ToolbarItemPlacement.automatic) {
                    Button(action: {
                        showAddItemView.toggle() // L'action de notre bouton
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                    })
                }
            })
        }
    }
}

#Preview {
    ContentView()
}
