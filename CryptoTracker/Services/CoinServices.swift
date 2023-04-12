//
//  CoinServices.swift
//  CryptoTracker
//
//  Created by Mohamed Makhlouf Ahmed on 09/04/2023.
//

import Foundation
import Combine

class CoinServices {
    @Published var coins : [CoinModel] = []
    var cancellables = Set<AnyCancellable>()
    init(){
      getCoins()
    }
    
    private func getCoins(){
        guard let url = URL(string:"https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&locale=en")
        else { return }
             NetworkingManager.download(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink { completion in
                NetworkingManager.handleCompletion(completion: completion)
            } receiveValue: { [weak self] returnedCoins in
                self?.coins  = returnedCoins
            }
            .store(in: &cancellables)

    }
}
