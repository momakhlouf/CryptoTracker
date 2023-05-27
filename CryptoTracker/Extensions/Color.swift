//
//  Color.swift
//  CryptoTracker
//
//  Created by Mohamed Makhlouf Ahmed on 09/04/2023.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
    static let  launch = ColorLaunch()
}

struct ColorTheme{
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")
}

struct ColorLaunch{
    let launchAccent = Color("LaunchAccentColor")
    let launchBackground = Color("LaunchBackgroundColor")
}
