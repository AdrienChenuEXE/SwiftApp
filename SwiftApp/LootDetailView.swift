//
//  LootDetailView.swift
//  SwiftApp
//
//  Created by Adrien CHENU on 1/19/24.
//

import SwiftUI

struct LootDetailView: View {
    @EnvironmentObject var inventory: Inventory
    var item : LootItem
    @State private var rotate = false
    @State private var shadowed: Bool = false
    @State private var shine: Bool = false
    
    @State var showAddItemView = false

    
    var body: some View {
        NavigationStack{
            VStack{
                VStack{
                    Rectangle()
                        .fill(
                            shine ? Color.yellow.opacity(0.3) : Color(item.rarity.getColor())
                        )
                        .frame(width: 150, height: 150)
                        .cornerRadius(20)
                        .shadow(
                            color: Color(item.rarity.getColor()),
                            radius: shadowed ? 100 : 0)
                        .overlay(
                            Text(item.type.getLogo())
                                .font(.system(size: 80))
                                .foregroundColor(.white)
                        )
                        .padding(.bottom, 20)
                        .rotation3DEffect(
                            rotate ? Angle(degrees: 360) : .zero,
                            axis: (x: -1.0, y: -0.5, z: 0.0)
                        )
                        .animation(.default, value: rotate)
                        .onAppear() {
                            Task {
                                try await Task.sleep(nanoseconds: 400_000_000)
                                
                                withAnimation(Animation.spring) {
                                    self.rotate.toggle()
                                }
                                
                                try await Task.sleep(nanoseconds: 200_000_000)
                                
                                withAnimation(Animation.bouncy.delay(0.2)) {
                                    self.shadowed.toggle()
                                }
                            }
                        }
                        .animation(.easeInOut.speed(0.8), value: shine)
                        .onTapGesture(){
                            Task {
                                withAnimation(Animation.bouncy.delay(0.2)){
                                    self.shine.toggle()
                                    self.shadowed.toggle()
                                }
                                
                                try await Task.sleep(nanoseconds: 400_000_000)
                                
                                withAnimation(Animation.bouncy.delay(0.2)){
                                    self.shine.toggle()
                                    self.shadowed.toggle()
                                }
                            }
                        }
                    Text(item.name)
                        .font(.title)
                        .foregroundStyle(item.rarity.getColor())
                }
                .padding(.bottom, 75)
                .padding(.top, 50)
                if item.rarity == Rarity.unique{
                    Rectangle()
                        .fill(Color(item.rarity.getColor()))
                        .frame(width: 350, height: 50)
                        .cornerRadius(20)
                        .overlay(
                            HStack{
                                Text("Item Unique ")
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                    .padding()
                                Text("🏆")
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                    .padding()
                            }
                        )
                        .padding(.bottom, 20)
                }
                VStack{
                    List{
                        Section{
                            HStack{
                                GameCard(game : item.game)
                                Text(item.game.name)
                            }
                            Text("In-Game : \(item.name)")
                            if let attackStrength = item.attackStrength{
                                Text("Puissance (ATQ) : \(attackStrength)")
                            }
                            else{
                                Text("Puissance (ATQ) : Inconnu")
                            }
                            Text("Possédé(s) : \(item.quantity)")
                            Text("Rareté : \(String(describing: item.rarity))")
                        } header: {
                            Text("INFORMATIONS")
                        }
                    }
                }
            }
            .sheet(isPresented: $showAddItemView, content: {
                AddItemView(item: item, isEditing: true)
                    .environmentObject(inventory)
            })
        }
        .toolbar(content: {
            ToolbarItem(placement: ToolbarItemPlacement.automatic) {
                Button(action: {
                    showAddItemView.toggle()
                }, label: {
                    HStack {
                        Image(systemName: "pencil")
                        Text("Editer")
                    }
                })
            }
        })
    }
}

/*
 #Preview {
 LootDetailView(
 item : items.randomElement()!
 )
 }
 */
