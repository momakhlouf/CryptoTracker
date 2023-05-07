//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Mohamed Makhlouf Ahmed on 09/04/2023.
//

import Foundation
import Combine

class HomeViewModel :ObservableObject{
    @Published var statistics : [StatisticsModel] = []
    
    @Published var coins : [CoinModel] = []
    @Published var portfolioCoins : [CoinModel] = []
    @Published var searchText : String = ""
    
    private let coinService   = CoinServices()
    private let marketService = MarketServices()
    private let portfolioDataService = PortfolioDataService()
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
            .combineLatest(coinService.$coins)
        // -important-  when user search and write fast, this will hit the api every char , then we will delay it here by debounce.
            .debounce(for: .seconds(0.5) , scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] returnedCoins in
                self?.coins = returnedCoins
            }
            .store(in: &cancellables)
        
        
        marketService.$marketData
            .map(mapMarket)
            .sink { returnedStats in
                self.statistics = returnedStats
            }
            .store(in: &cancellables)
        
        $coins
            .combineLatest(portfolioDataService.$saveEntities)
            .map { coinModels , portfolioEntities in
                coinModels
                    .compactMap { (coin) -> CoinModel? in
                        guard let entity = portfolioEntities.first(where: {$0.coinID == coin.id}) else {
                            return nil
                        }
                        return coin.updateHoldings(amount: entity.amount)
                    }
            }
            .sink { [weak self] returnedCoins in
                self?.portfolioCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
    
    func updatePortfolio(coin : CoinModel , amount : Double){
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    
    
    private func filterCoins(text : String , coins : [CoinModel]) -> [CoinModel]{
        guard !text.isEmpty else {
            return coins
        }
        
        return coins.filter { coin  in
            return coin.name.lowercased().contains(text.lowercased()) ||
            coin.symbol.lowercased().contains(text.lowercased()) ||
            coin.id.lowercased().contains(text.lowercased())
            
        }
    }
    
    
    private func mapMarket(marketDataModel :  MarketDataModel?) -> [StatisticsModel] {
        var stats : [StatisticsModel] = []
        
        guard let data = marketDataModel else {
            return stats
        }
        let marketCap = StatisticsModel(title: "Market Cap", value: data.marketCap , percentage: data.marketCapChangePercentage24HUsd)
        let volume = StatisticsModel(title: "24h Volume", value: data.volume)
        let btcDominance = StatisticsModel(title: "BTC Dominanace", value: data.btcPercentage)
        let portfolio = StatisticsModel(title: "Portoflio Value", value: "$0.00" , percentage: 0)
        stats.append(contentsOf: [marketCap , volume, btcDominance,portfolio])
        
        return stats
    }
}

