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
    @State var name : String = ""
    @State var rarity : Rarity = .common
    @State var quantity : Int = 1
    @State var attackItem : Bool = false
    @State var type : ItemType = .unknown
    @State var game : Game = .emptyGame
    @State var attackStrength : Int?
    
    @State var errorMessage : String = ""
    @State var showAlert : Bool = false
    
    var body: some View {
        HStack{
            Text("Ajouter un loot")
                .font(.title2)
        }
        Form { // Wrapper de notre formulaire
            Section { // Correspond à une section du formulaire
                TextField("Nom de l'objet", text: $name)
                Picker("Rarete", selection: $rarity) {
                    ForEach(Rarity.allCases, id: \.self) { rarity in
                        Text(String(describing: rarity).capitalized)
                    }
                }
            }
            Section{
                Picker("Jeu", selection: $game) {
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
                    Text("\(type.getLogo())")
                }
                Picker("Type", selection: $type){
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
                        addItem()
                        dismiss()
                    } else {
                        showAlert = true
                    }
                }, label: {
                    Text("Ajouter")
                })
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Erreur"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
        
    }
    
    func validateForm() -> Bool {
        if name.isEmpty || name.count < 3 {
            errorMessage = "Le nom de l'objet doit faire au moins 3 caractères."
            return false
        }
        
        if type == .unknown {
            errorMessage = "Veuillez sélectionner un type valide."
            return false
        }
        
        if game == .emptyGame {
            errorMessage = "Veuillez sélectionner un jeu valide."
            return false
        }
        
        return true
    }
    
    func addItem() {
        inventory.addItem(item: LootItem(
            quantity: quantity,
            name: name,
            type: type,
            rarity: rarity,
            attackStrength: attackStrength,
            game: game
        )
        )
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

#Preview {
    AddItemView()
}
