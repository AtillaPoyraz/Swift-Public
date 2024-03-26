//
//  CoinTableViewCell.swift
//  coinTracker
//
//  Created by Atilla Poyraz on 1.12.2023.
//

import UIKit
import Kingfisher

class CoinTableViewCell: UITableViewCell {
    
    @IBOutlet weak var textNameLabel: UILabel!
    @IBOutlet weak var textQuoteLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var coinView: UIView!
    @IBOutlet weak var favouriteButton: UIButton!
    
    
    func configure(with coin: Coin) {
        
        
        textNameLabel.text = "\(coin.name) (\(coin.symbol)):"
        textQuoteLabel.text = "\(String(format: "%.6f", coin.quotes.USD.price))"
        let imageURL = URL(string: "https://static.coinpaprika.com/coin/\(coin.id)/logo.png?rev=10557311)")
        imgView.kf.setImage(with: imageURL, placeholder: UIImage(named: "placeholderImage"), options: [.transition(.fade(0.2)), .scaleFactor(UIScreen.main.scale), .processor(ResizingImageProcessor(referenceSize: CGSize(width: 32, height: 32)))])
        coinView.layer.cornerRadius = coinView.frame.height / 4
//        let favouriteImage = coin.isFavourite ? UIImage(named: "star.fill") : UIImage(named: "star")
//           favouriteButton.setImage(favouriteImage, for: .normal)
    }
  
}
