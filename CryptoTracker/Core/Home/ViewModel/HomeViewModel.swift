//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Mohamed Makhlouf Ahmed on 09/04/2023.
//

import Foundation
import Combine

class HomeViewModel :ObservableObject{
    
    @Published var coins : [CoinModel] = []
    @Published var portfolioCoins : [CoinModel] = []
    private let service = CoinServices()
    var cancellables = Set<AnyCancellable>()

    init() {
       getData()
    }
    
    func getData(){
        service.$coins
            .sink { [weak self] returnedCoins in
            self?.coins = returnedCoins
        }
            .store(in: &cancellables)
    }
    
    
}
