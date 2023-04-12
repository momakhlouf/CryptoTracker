//
//  UIApplication.swift
//  CryptoTracker
//
//  Created by Mohamed Makhlouf Ahmed on 12/04/2023.
//

import Foundation
import SwiftUI
extension UIApplication {
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
