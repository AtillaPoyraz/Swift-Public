//
//  Coin.swift
//  coinTracker
//
//  Created by Atilla Poyraz on 1.12.2023.
//

import Foundation

struct Coin: Codable {
    let id: String
    let name: String
    let symbol: String
//    var isFavourite = false
    let quotes: Quote
}

struct Quote: Codable {
    let USD: USD
}

struct USD: Codable {
    let price: Double
    let percent_change_15m: Double
    let percent_change_30m: Double
    let percent_change_1h: Double
    let percent_change_6h: Double
    let percent_change_12h: Double
    let percent_change_24h: Double
    let percent_change_7d: Double
    let percent_change_30d: Double
    let percent_change_1y: Double
}
