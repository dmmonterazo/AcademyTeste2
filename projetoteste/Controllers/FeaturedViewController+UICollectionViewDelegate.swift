//
//  FeaturedViewController+UICollectionViewDelegate.swift
//  projetoteste
//
//  Created by dmm on 13/07/22.
//

import UIKit

extension FeaturedViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath) {
        print("tocou")
        
        let movie: Movie? 
        
        if collectionView == popularCollectionView {
            print(popularMovies[indexPath.item])
            movie = popularMovies[indexPath.item]
                  } else {
                      print(topRatedMovies[indexPath.item])
                      movie = topRatedMovies[indexPath.item]
        }
        self.performSegue(withIdentifier: "detailsSegue",
            sender: movie)
    
    }
}
