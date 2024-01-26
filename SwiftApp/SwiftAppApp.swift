//
//  SwiftAppApp.swift
//  SwiftApp
//
//  Created by Adrien CHENU on 1/19/24.
//

import SwiftUI

@main
struct SwiftAppApp: App {
    @AppStorage("isOnboardingDone") var isOnboardingDone: Bool = false
    
   var body: some Scene {
       WindowGroup {
           if isOnboardingDone {
               ContentView()
           } else {
               OnboardingView(isOnboardingDone: $isOnboardingDone)
           }
       }
   }
}
