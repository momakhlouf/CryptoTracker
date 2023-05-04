//
//  StatisticsModel.swift
//  CryptoTracker
//
//  Created by Mohamed Makhlouf Ahmed on 12/04/2023.
//

import Foundation

struct StatisticsModel : Identifiable {
    let id = UUID().uuidString
    let title : String
    let value : String
    let percentage : Double?
    
    init(title: String, value: String, percentage: Double? = nil) {
        self.title = title
        self.value = value
        self.percentage = percentage
    }
}
