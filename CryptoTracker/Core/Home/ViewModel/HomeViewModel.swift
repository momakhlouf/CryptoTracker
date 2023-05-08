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
    @Published var sortOption : SortOption = .holdings
    private let coinService   = CoinServices()
    private let marketService = MarketServices()
    private let portfolioDataService = PortfolioDataService()
    var cancellables = Set<AnyCancellable>()
    
    
    
    enum SortOption{
        case rank , reversedRank , holdings , reversedHoldings , price , priceReversed
    }
    
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
            .combineLatest(coinService.$coins , $sortOption)
        // -important-  when user search and write fast, this will hit the api every char , then we will delay it here by debounce.
            .debounce(for: .seconds(0.5) , scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink { [weak self] returnedCoins in
                self?.coins = returnedCoins
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
        
        
        marketService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapMarket)
            .sink { returnedStats in
                self.statistics = returnedStats
            }
            .store(in: &cancellables)
    }
    
    func updatePortfolio(coin : CoinModel , amount : Double){
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    
    private func filterAndSortCoins(text : String , coins : [CoinModel] , sort : SortOption) -> [CoinModel]{
        var filteredCoins = filterCoins(text: text, coins: coins)
         sortCoins(sort: sort, coins: &filteredCoins)
        return filteredCoins
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
                // inout instead of return function - -> [coinModel]
    private func sortCoins(sort : SortOption , coins : inout [CoinModel]){
        
        switch sort {
        case .rank , .holdings:
             coins.sort(by: {$0.rank < $1.rank})
        case .reversedRank , .reversedHoldings:
             coins.sort(by: {$0.rank > $1.rank})
        case .price:
             coins.sort(by: {$0.currentPrice > $1.currentPrice})
        case .priceReversed:
             coins.sort(by: {$0.currentPrice < $1.currentPrice})
        }
    }
    
    func refreshData() {
        coinService.getCoins()
        marketService.getData()
    }
    
    
    private func mapMarket(marketDataModel :  MarketDataModel? , portfolioCoins : [CoinModel]) -> [StatisticsModel] {
        var stats : [StatisticsModel] = []
        
        guard let data = marketDataModel else {
            return stats
        }
        let marketCap = StatisticsModel(title: "Market Cap", value: data.marketCap , percentage: data.marketCapChangePercentage24HUsd)
        let volume = StatisticsModel(title: "24h Volume", value: data.volume)
        let btcDominance = StatisticsModel(title: "BTC Dominanace", value: data.btcPercentage)
        
        let portfolioValue = portfolioCoins
                             .map({$0.currentHoldingsValue})
                             .reduce(0, +)
        
        let previousValue = portfolioCoins.map { (coin) -> Double in
            let currentValue = coin.currentHoldingsValue
            let percentChange = (coin.priceChangePercentage24H ?? 0) / 100
            let previousValue = currentValue / (1 + percentChange)
            return previousValue
        }
            .reduce( 0 , +)
        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
        
        let portfolio = StatisticsModel(title: "Portoflio Value", value: portfolioValue.currencyFormat() , percentage: percentageChange)
        stats.append(contentsOf: [marketCap , volume, btcDominance,portfolio])
        
        return stats
    }
}

