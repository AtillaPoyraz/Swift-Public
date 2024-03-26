//
//  CoinChartViewModel.swift
//  coinTracker
//
//  Created by Atilla Poyraz on 1.12.2023.
//

import Foundation
import DGCharts

class CoinChartViewModel {
    private let coin: Coin

    init(coin: Coin) {
        self.coin = coin
    }

    var name: String {
        return coin.name
    }

    var symbol: String {
        return coin.symbol
    }

    var quote: String {
        return String(format: "$%.9f", coin.quotes.USD.price)
    }

    var imageURL: URL? {
        return URL(string: "https://static.coinpaprika.com/coin/\(coin.id)/logo.png?rev=10557311")
    }

    var chartData: [ChartDataEntry] {
        let aYear = ((coin.quotes.USD.price) / (1 + (coin.quotes.USD.percent_change_1y) / 100))
        let thirtyDay = ((coin.quotes.USD.price) / (1 + (coin.quotes.USD.percent_change_30d) / 100))
        let sevenDay = ((coin.quotes.USD.price) / (1 + (coin.quotes.USD.percent_change_7d) / 100))
        let oneDay = ((coin.quotes.USD.price) / (1 + (coin.quotes.USD.percent_change_24h) / 100))
        let twelveHour = ((coin.quotes.USD.price) / (1 + (coin.quotes.USD.percent_change_12h) / 100))
        let sixHour = ((coin.quotes.USD.price) / (1 + (coin.quotes.USD.percent_change_6h) / 100))
        let anHour = ((coin.quotes.USD.price) / (1 + (coin.quotes.USD.percent_change_1h) / 100))
        let thirtyMinute = ((coin.quotes.USD.price) / (1 + (coin.quotes.USD.percent_change_30m) / 100))
        let fifteenMinute = ((coin.quotes.USD.price) / (1 + (coin.quotes.USD.percent_change_15m) / 100))

        let yValues: [ChartDataEntry] = [	
            ChartDataEntry(x: 1, y: aYear),
            ChartDataEntry(x: 2, y: thirtyDay),
            ChartDataEntry(x: 3, y: sevenDay),
            ChartDataEntry(x: 4, y: oneDay),
            ChartDataEntry(x: 5, y: twelveHour),
            ChartDataEntry(x: 6, y: sixHour),
            ChartDataEntry(x: 7, y: anHour),
            ChartDataEntry(x: 8, y: thirtyMinute),
            ChartDataEntry(x: 9, y: fifteenMinute),
            ChartDataEntry(x: 10, y: coin.quotes.USD.price)
        ]

        return yValues
    }
}
