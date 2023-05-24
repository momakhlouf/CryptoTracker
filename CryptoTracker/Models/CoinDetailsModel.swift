//
//  CoinDetailsModel.swift
//  CryptoTracker
//
//  Created by Mohamed Makhlouf Ahmed on 23/05/2023.
//

import Foundation

/*
 https://api.coingecko.com/api/v3/coins/bitcoin?localization=false&market_data=false&developer_data=false&sparkline=false
 */


// MARK: - MarketModel
struct CoinDetailsModel: Codable {
    let id: String?
    let symbol, name: String?
      let blockTimeInMinutes: Int?
    let hashingAlgorithm: String?
    let categories: [String]?
    let description: Description?
    let links: Links?
  
    enum CodingKeys: String, CodingKey {
        case id, symbol, name
        case blockTimeInMinutes = "block_time_in_minutes"
        case hashingAlgorithm = "hashing_algorithm"
        case categories
        case description, links
    }
}

struct Description: Codable {
    let en: String?
}


struct Links: Codable {
    let homepage: [String]?
    let subredditURL: String?

    enum CodingKeys: String, CodingKey {
        case homepage
        case subredditURL = "subreddit_url"
    }
}



