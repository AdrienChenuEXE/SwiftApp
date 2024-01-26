//
//  LootItem.swift
//  SwiftApp
//
//  Created by Adrien CHENU on 1/19/24.
//

import Foundation

struct LootItem : Hashable{
    var quantity : Int = 1
    var name : String
    var type : ItemType
    var rarity : Rarity
    var attackStrength: Int?
    var game: Game
}

enum ItemType: CaseIterable {
    case magic,
         fire,
         ice,
         wind,
         poison,
         thunder,
         dagger,
         shield,
         bow,
         ring,
         unknown
    
    func getLogo() -> String {
        switch self {
            case .magic: return "⭐️"
            case .fire: return "🔥"
            case .ice: return "❄️"
            case .wind: return "💨"
            case .poison: return "☠️"
            case .thunder: return "⚡️"
            case .dagger: return "🗡️"
            case .shield: return "🛡️"
            case .bow: return "🏹"
            case .ring: return "💍"
            case .unknown: return "🎲"
        }
    }
}
