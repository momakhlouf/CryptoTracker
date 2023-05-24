//
//  String.swift
//  CryptoTracker
//
//  Created by Mohamed Makhlouf Ahmed on 25/05/2023.
//

import Foundation

extension String {
    var removingHTMLOccurrences : String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "" , options: .regularExpression)
    }
}
