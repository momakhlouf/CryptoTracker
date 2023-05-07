//
//  MarketServices.swift
//  CryptoTracker
//
//  Created by Mohamed Makhlouf Ahmed on 04/05/2023.
//

import Foundation
import Combine

class MarketServices {
 
    @Published var marketData : MarketDataModel? = nil
    var cancellables = Set<AnyCancellable>()
   
    init(){
        getData()
    }
    
     func getData(){
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else {return}
         NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink { completion in
                NetworkingManager.handleCompletion(completion: completion)
            } receiveValue: { returnedData in
                self.marketData = returnedData.data
            }
            .store(in: &cancellables)

    }
}
