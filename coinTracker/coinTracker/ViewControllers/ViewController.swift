//
//  ViewController.swift
//  coinTracker
//
//  Created by Atilla Poyraz on 30.11.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    var viewModel = CoinListViewModel()
    var isFavourite = false
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        viewModel.onDataUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coinCell", for: indexPath) as! CoinTableViewCell
        let coin = viewModel.coin(at: indexPath.row)
        cell.configure(with: coin)
//        cell.favouriteButton.addTarget(self, action: #selector(favouriteButtonTapped(_:)), for: .touchUpInside)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedIndexPath = indexPath
         performSegue(withIdentifier: "toChartView", sender: nil)
    }

//    @objc func favouriteButtonTapped(_ sender: UIButton) {
//           // Handle the favorite button tap here
//           if let cell = sender.superview?.superview as? CoinTableViewCell, let indexPath = tableView.indexPath(for: cell) {
//               var selectedCoin = viewModel.coin(at: indexPath.row)
//               // Toggle the favorite state or perform any other desired action
//               selectedCoin.isFavourite.toggle()
//               // Update UI or perform any other actions based on the favorite state
//           }
//       }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterCoins(with: searchText)
    }

    @IBAction func goToLoginViewController(_ sender: UIButton) {
        performSegue(withIdentifier: "goToLogin", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToLogin" {
            // handle preparation for the login segue if needed
        } else if segue.identifier == "toChartView" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let selectedCoin = viewModel.coin(at: indexPath.row)
                let destinationVC = segue.destination as! CoinChartViewController
                destinationVC.viewModel = CoinChartViewModel(coin: selectedCoin)
            }
        }
    }
}

