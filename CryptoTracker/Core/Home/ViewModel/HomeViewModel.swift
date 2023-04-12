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
    @Published var searchText : String = ""

    private let service = CoinServices()
    var cancellables = Set<AnyCancellable>()

    init() {
       addSubscribers()
    }
    
    func addSubscribers(){
//        service.$coins
//            .sink { [weak self] returnedCoins in
//            self?.coins = returnedCoins
//        }
//            .store(in: &cancellables)
        
        $searchText
            .combineLatest(service.$coins)
              // -important-  when user search and write fast, this will hit the api every char , then we will delay it here by debounce.
            .debounce(for: .seconds(0.5) , scheduler: DispatchQueue.main)
            .map{(text, startingCoins ) -> [CoinModel] in
                guard !text.isEmpty else {
                     return startingCoins
                }
                
               return startingCoins.filter { coin  in
                    return coin.name.lowercased().contains(text.lowercased()) ||
                           coin.symbol.lowercased().contains(text.lowercased()) ||
                           coin.id.lowercased().contains(text.lowercased())
                    
                  }
             }
            .sink { [weak self] returnedCoins in
                self?.coins = returnedCoins
            }
            .store(in: &cancellables)
                
            
        
    }
           
}

