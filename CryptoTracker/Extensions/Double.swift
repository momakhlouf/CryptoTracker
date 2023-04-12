//
//  Double.swift
//  CryptoTracker
//
//  Created by Mohamed Makhlouf Ahmed on 09/04/2023.
//

import Foundation

extension Double {
    private var currencyFormatter : NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = .current
        formatter.currencyCode = "usd"
        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
        
    }
    
    func currencyFormat() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter.string(from: number) ?? "$0.00"
    }
    
    func numberStringFormat() -> String{
        return String(format: "%.2f", self)
    }
    
    func percentStringFormat()-> String{
        return numberStringFormat() + "%"
    }
}
