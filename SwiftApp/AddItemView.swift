//
//  AddItemView.swift
//  SwiftApp
//
//  Created by Adrien CHENU on 1/19/24.
//

import SwiftUI

struct AddItemView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var inventory: Inventory
    //@State var name : String = ""
    //@State var rarity : Rarity = .common
    @State var quantity : Int = 1
    @State var attackItem : Bool = false
    //@State var type : ItemType = .unknown
    //@State var game : Game = .emptyGame
    @State var attackStrength : Int?
    
    @State var errorMessage : String = ""
    @State var showAlert : Bool = false
    
    @State var item: LootItem = LootItem(name: "", type: .unknown, rarity: .common, game: .emptyGame)
    @State var isEditing : Bool = false

        
    var body: some View {
        HStack{
            if isEditing{
                Text("Modifier le loot")
                    .font(.title2)
                    .padding(.top, 12)
            }else{
                Text("Ajouter un loot")
                    .font(.title2)
                    .padding(.top, 12)
            }
        }
        Form {
            Section {
                TextField("Nom de l'objet", text: $item.name)
                Picker("Rarete", selection: $item.rarity) {
                    ForEach(Rarity.allCases, id: \.self) { rarity in
                        Text(String(describing: rarity).capitalized)
                    }
                }
            }
            Section{
                Picker("Jeu", selection: $item.game) {
                    ForEach(availableGames, id: \.self) { game in
                        Text(game.name.capitalized)
                    }
                }
                Stepper(value: $quantity, in: 1...100) {
                    Text("Quantité : \(quantity)")
                }
            }
            Section{
                HStack{
                    Text("Type")
                    Spacer()
                    Text("\(item.type.getLogo())")
                }
                Picker("Type", selection: $item.type){
                    ForEach(ItemType.allCases, id: \.self) { type in
                        Text(type.getLogo())
                    }
                }
                .pickerStyle(PalettePickerStyle())
            }
            Section {
                Toggle(isOn: $attackItem) {
                    Text("Objet d'attaque")
                }
                
                
                if attackItem {
                    Stepper("Force d'attaque : \(attackStrength ?? 0)", value: Binding<Int>(
                        get: { self.attackStrength ?? 0 },
                        set: { self.attackStrength = $0 }
                    ), in: 0...100)
                }
            }
            Section{
                Button(action: {
                    if validateForm() {
                        if isEditing {
                            updateItem(item: item)
                        } else {
                            addItem()
                        }
                        dismiss()
                    } else {
                        showAlert = true
                    }
                }, label: {
                    if isEditing{
                        Text("Sauvegarder")
                    } else{
                        Text("Ajouter")
                    }
                })
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Erreur"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
        
    }
    
    func validateForm() -> Bool {
        if item.name.isEmpty || item.name.count < 3 {
            errorMessage = "Le nom de l'objet doit faire au moins 3 caractères."
            return false
        }
        
        if item.type == .unknown {
            errorMessage = "Veuillez sélectionner un type valide."
            return false
        }
        
        if item.game == .emptyGame {
            errorMessage = "Veuillez sélectionner un jeu valide."
            return false
        }
        
        return true
    }
    
    func addItem() {
        inventory.addItem(item: LootItem(
            quantity: quantity,
            name: item.name,
            type: item.type,
            rarity: item.rarity,
            attackStrength: attackStrength,
            game: item.game
            )
        )
    }
    
    func updateItem(item: LootItem) {
        inventory.updateItem(item: item)
    }
}

enum Rarity : CaseIterable{
    case common,
         uncommon,
         rare,
         epic,
         legendary,
         unique
    
    func getColor() -> Color {
        switch self {
        case .common: return Color.gray
        case .uncommon: return Color.green
        case .rare: return Color.blue
        case .epic: return Color.purple
        case .legendary: return Color.yellow
        case .unique: return Color.red
        }
    }
}

/*
#Preview {
    AddItemView(
    )
}
*/
