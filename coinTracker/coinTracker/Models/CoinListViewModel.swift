//
//  CoinListViewModel.swift
//  coinTracker
//
//  Created by Atilla Poyraz on 1.12.2023.
//

import Foundation

class CoinListViewModel {
    let apiUrl = URL(string: "https://api.coinpaprika.com/v1/tickers")!
    
    private var coins: [Coin] = []
    private var filteredCoins: [Coin] = []
    private var timer: Timer?

    
    var numberOfRows: Int {
        return filteredCoins.count
    }

    func coin(at index: Int) -> Coin {
        return filteredCoins[index]
    }

    var selectedIndexPath: IndexPath?

    @objc var onDataUpdate: (() -> Void)?

    init() {
        fetchData()
        startTimer()
    }

    deinit {
        stopTimer()
    }

    func fetchData() {
        URLSession.shared.dataTask(with: apiUrl) { [weak self] data, response, error in
            if let error = error {
                print("Error occurred: \(error)")
                return
            }
            
            guard let data = data else {
                print("Data not found.")
                return
            }
            
            do {
                let coins = try JSONDecoder().decode([Coin].self, from: data)
                self?.coins = coins
                self?.filteredCoins = coins
                self?.onDataUpdate?()
            } catch {
                print("Decode error: \(error)")
            }
        }.resume()
    }

    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 300, target: self, selector: #selector(updateData), userInfo: nil, repeats: true)
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    @objc func updateData() {
        fetchData()
    }

    func filterCoins(with searchText: String) {
        if searchText.isEmpty {
            filteredCoins = coins
        } else {
            filteredCoins = coins.filter { coin in
                return coin.name.lowercased().contains(searchText.lowercased()) ||
                    coin.symbol.lowercased().contains(searchText.lowercased())
            }
        }
        onDataUpdate?()
    }
}
