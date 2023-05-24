//
//  CoinDetailsServices.swift
//  CryptoTracker
//
//  Created by Mohamed Makhlouf Ahmed on 23/05/2023.
//

import Foundation
import Combine

class CoinDetailsServices{
    @Published var coinDetails : CoinDetailsModel? = nil
    var cancellables = Set<AnyCancellable>()
    var coin: CoinModel
    init(coin : CoinModel){
        self.coin = coin
      getCoins()
    }
    
     func getCoins(){
         guard let url = URL(string:"https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false")
        else { return }
             NetworkingManager.download(url: url)
            .decode(type: CoinDetailsModel.self, decoder: JSONDecoder())
            .sink { completion in
                NetworkingManager.handleCompletion(completion: completion)
            } receiveValue: { [weak self] returnedCoinDetails in
                self?.coinDetails  = returnedCoinDetails
                print(self?.coinDetails)
            }
            .store(in: &cancellables)
    }
}
