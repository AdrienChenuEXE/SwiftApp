//
//  OnboardingPageView.swift
//  SwiftApp
//
//  Created by Adrien CHENU on 1/25/24.
//

import SwiftUI

struct OnboardingPageView: View {
    var title: String
    var description: String
    var imageName: String
    var iconColor: Color
    var isLastPage: Bool
    var onNextTapped: () -> Void
    var onboardingCompletedAction: () -> Void

    var body: some View {
        VStack {
            Spacer()
            
            Text(title)
                .font(.system(size: 60))
                .multilineTextAlignment(.center)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .padding()
            
            Circle()
                .fill(
                    iconColor
                )
                .frame(width: 200, height: 200)
                .overlay(
                    Image(systemName: imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .colorInvert()
                        .padding(60)
                )
            
            Text(description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()

            Button(isLastPage ? "Commencer" : "Suivant") {
                if isLastPage {
                    onboardingCompletedAction()
                } else {
                    onNextTapped()
                }
            }
            .padding()
            
            Spacer()
        }
    }
}

/*
#Preview {
    OnboardingPageView(
        title: "Titre",
        description: "desc",
        imageName: "") {
            
        }
}
*/
