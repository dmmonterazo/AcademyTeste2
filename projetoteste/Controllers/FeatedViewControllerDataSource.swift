//
//  FeatedViewControllerDataSource.swift
//  projetoteste
//
//  Created by dmm on 13/07/22.
//

import Foundation
import UIKit
extension FeaturedViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularMovies.count
    }
    
    fileprivate func makeNowPlayingCell( indexPath: IndexPath) -> NowPlayingCollectionViewCell {
        if let cell = nowPlayingCollectionView.dequeueReusableCell(withReuseIdentifier:
                                                                    NowPlayingCollectionViewCell.cellidentifier, for: indexPath) as?
            NowPlayingCollectionViewCell {
            
            let nowPlayingMovie = Movie.nowPlayingMovies()
            let titulo: String = nowPlayingMovie[indexPath.item].title
            
            cell.setup(title: titulo,
                       year:"\(Movie.nowPlayingMovies()[indexPath.item].releaseDate.prefix(4))" ,
                       image: UIImage(named: nowPlayingMovies[indexPath.item].poster) ??
                       UIImage())
                                     
            return cell
        }
        return NowPlayingCollectionViewCell()
    }
    
    
    fileprivate func makePopularCell(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "popularCell", for: indexPath) as? PopularCollectionViewCell {
            
            cell.setup(title: popularMovies[indexPath.item].title,
                       image: UIImage(named:
                                        popularMovies[indexPath.item].backdrop) ?? UIImage())
            
            cell.titleLabel.text = popularMovies[indexPath.item].title
            cell.image.image = UIImage(named: popularMovies[indexPath.item].backdrop)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == popularCollectionView {
            return makePopularCell(collectionView, indexPath)
        }
        else {
            return makeNowPlayingCell(indexPath:indexPath)
        }
    }
}
