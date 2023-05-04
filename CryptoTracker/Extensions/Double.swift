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
    
    // Convert a Double to a String with K, M, Bn, Tr abbreviations.
    /// ```
    /// Convert 12 to 12.00
    /// Convert 1234 to 1.23K
    /// Convert 123456 to 123.45K
    /// Convert 12345678 to 12.34M
    /// Convert 1234567890 to 1.23Bn
    /// Convert 123456789012 to 123.45Bn
    /// Convert 12345678901234 to 12.34Tr
    /// ```
    func formattedWithAbbreviations() -> String {
        let num = abs(Double(self))
        let sign = (self < 0) ? "-" : ""

        switch num {
        case 1_000_000_000_000...:
            let formatted = num / 1_000_000_000_000
            let stringFormatted = formatted.numberStringFormat()
            return "\(sign)\(stringFormatted)Tr"
        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            let stringFormatted = formatted.numberStringFormat()
            return "\(sign)\(stringFormatted)Bn"
        case 1_000_000...:
            let formatted = num / 1_000_000
            let stringFormatted = formatted.numberStringFormat()
            return "\(sign)\(stringFormatted)M"
        case 1_000...:
            let formatted = num / 1_000
            let stringFormatted = formatted.numberStringFormat()
            return "\(sign)\(stringFormatted)K"
        case 0...:
            return self.numberStringFormat()

        default:
            return "\(sign)\(self)"
        }
    }
    
    
}
