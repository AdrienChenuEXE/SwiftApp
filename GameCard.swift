//
//  GameCard.swift
//  SwiftApp
//
//  Created by Adrien CHENU on 1/23/24.
//

import SwiftUI

struct GameCard: View {
    @State var game : Game
    
    var body: some View {
        if let coverName = game.coverName{
            Image(coverName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 58)
                .cornerRadius(4)
        }
        else{
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.gray]), startPoint: .top, endPoint: .bottom)
                    .opacity(0.4)
                    .cornerRadius(4)
                
                Image(systemName: "rectangle.slash")
                    .foregroundColor(.black)
                    .opacity(0.4)
                    .padding()
            }.frame(width: 20, height: 58)
                .padding(.horizontal, 20)
        }
    }
}

#Preview {
    GameCard(
        game : availableGames.randomElement()!
    )
}
