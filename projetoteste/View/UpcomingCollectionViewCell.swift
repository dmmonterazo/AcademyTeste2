//
//  UpcomingCollectionViewCell.swift
//  projetoteste
//
//  Created by dmm on 18/07/22.
//

import UIKit

class UpcomingCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "upcomingCell"
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
   
    func setup(title: String, year: String, image: UIImage) {
        titleLabel.text = title
        dateLabel.text = year
        imageView.image = image
    }
    
}

