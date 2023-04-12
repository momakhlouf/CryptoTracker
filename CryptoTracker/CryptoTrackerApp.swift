//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by Mohamed Makhlouf Ahmed on 09/04/2023.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {
    @StateObject var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            
            NavigationStack{
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
