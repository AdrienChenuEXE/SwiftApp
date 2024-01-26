//
//  OnboardingView.swift
//  SwiftApp
//
//  Created by Adrien CHENU on 1/25/24.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var isOnboardingDone: Bool
    @State private var currentPage = 0

    var body: some View {
        TabView(selection: $currentPage) {
            OnboardingPageView(
                title: "Gérer ses loots",
                description: "Ajoutez facilement vos trouvailles et vos achats à votre collection personnelle.",
                imageName: "gym.bag.fill",
                iconColor: Color.blue,
                isLastPage: false,
                onNextTapped: {
                currentPage += 1
            }, onboardingCompletedAction: {
                isOnboardingDone = true
            })
            .tag(0)

            OnboardingPageView(
                title: "Votre wishlist",
                description: "Créez une liste de souhaits pour garder une trace des  articles que vous voulez acquérir.",
                imageName: "wand.and.stars",
                iconColor: Color.purple,
                isLastPage: false,
                onNextTapped: {
                currentPage += 1
            }, onboardingCompletedAction: {
                isOnboardingDone = true
            })
            .tag(1)

            OnboardingPageView(
                title: "En un coup d'oeil",
                description: "Accédez rapidement à vos fonctionalités clés depuis l'écran d'acceuil de votre appareil.",
                imageName: "iphone.case",
                iconColor: Color.orange,
                isLastPage: true,
                onNextTapped: {
                currentPage += 1
            }, onboardingCompletedAction: {
                isOnboardingDone = true
            })
            .tag(2)
        }
        .tabViewStyle(PageTabViewStyle())
        .onAppear {
            UINavigationBar.appearance().isHidden = true
        }
    }
}


#Preview {
    OnboardingView(
        isOnboardingDone: .constant(false)
    )
}

