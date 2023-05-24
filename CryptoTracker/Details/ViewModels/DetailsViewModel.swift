//
//  DetailsViewModel.swift
//  CryptoTracker
//
//  Created by Mohamed Makhlouf Ahmed on 24/05/2023.
//

import Foundation
import Combine

class DetailsViewModel : ObservableObject{
    @Published var coin : CoinModel
    private var coinDetailsService : CoinDetailsServices
    private var cancellables = Set<AnyCancellable>()
    
    @Published var overViewStatistics : [StatisticsModel] = []
    @Published var additionalStatistics : [StatisticsModel] = []


    init(coin : CoinModel) {
        self.coin = coin
        self.coinDetailsService = CoinDetailsServices(coin: coin)
        self.addSubscribers()
    }
    
    func addSubscribers(){
        coinDetailsService.$coinDetails
            .combineLatest($coin)
            .map(mapToStat)
            .sink { returnedDetails in
                self.overViewStatistics = returnedDetails.overView
                self.additionalStatistics = returnedDetails.additional
            }
            .store(in: &cancellables)
        
    }
    
    
    func mapToStat(coinDetailsModel  : CoinDetailsModel?, coinModel : CoinModel) -> (overView : [StatisticsModel] , additional : [StatisticsModel]){
      let overViewArray = createOverViewArray(coinModel: coinModel)
      let additionalArray = createAdditionalArray(coinDetailsModel: coinDetailsModel, coinModel: coinModel)
        
      return (overViewArray,additionalArray)
    }
    
    private func createOverViewArray(coinModel : CoinModel) -> [StatisticsModel]{
        let price = coinModel.currentPrice.currencyFormat()
        let pricePercentChange = coinModel.priceChangePercentage24H
        let priceStat = StatisticsModel(title: "Current Price", value: price, percentage: pricePercentChange)
        
        let marketCap =  "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange = coinModel.marketCapChangePercentage24H
        let marketCapStat = StatisticsModel(title: "Market Capitalization", value: marketCap , percentage: marketCapPercentChange)
        
        let rank = "\(coinModel.rank)"
        let rankStat = StatisticsModel(title: "Rank", value: rank)
        
        let volume = "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = StatisticsModel(title: "Volume", value: volume)
        
        let overViewArray : [StatisticsModel] = [priceStat , marketCapStat , rankStat , volumeStat]
        
        return overViewArray
    }
    
   private func createAdditionalArray(coinDetailsModel  : CoinDetailsModel?, coinModel : CoinModel) -> [StatisticsModel]{
        let high = coinModel.high24H?.currencyFormat() ?? "n/a"
        let highStat = StatisticsModel(title: "24h High", value: high)
        
        let low = coinModel.low24H?.currencyFormat() ?? "n/a"
        let lowStat = StatisticsModel(title: "24h Low", value: low)
        
        let priceChange = coinModel.priceChange24H?.currencyFormat() ?? "n/a"
        let pricePercentChange2 = coinModel.priceChangePercentage24H
        let priceChangeStat = StatisticsModel(title: "24h Price Change", value: priceChange , percentage: pricePercentChange2)
        
        let marketCapChange =  "$" + (coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange2 = coinModel.marketCapChangePercentage24H
        let marketCapChangeStat = StatisticsModel(title: "24h Market Cap Change", value: marketCapChange , percentage: marketCapPercentChange2)
        
        let blockTime = coinDetailsModel?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockTimeStat = StatisticsModel(title: "Block Time", value: blockTimeString)
        let hashing = coinDetailsModel?.hashingAlgorithm ?? "n/a"
        let hashingStat = StatisticsModel(title: "Hashing Algorithm", value: hashing)
        
        let additionalArray : [StatisticsModel] = [highStat , lowStat , priceChangeStat , marketCapChangeStat , blockTimeStat , hashingStat]
        
        return additionalArray

    }
}
