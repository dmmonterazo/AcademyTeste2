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
            
            let movie = topRatedMovies[indexPath.item]
            
            cell.setup(title: movie.title,
                       year:"\(movie.releaseDate.prefix(4))" ,
                       image: UIImage()
            )
            
            
            Task {
                let imageData = await Movie.downloadImageData(withPath: movie.posterPath)
                let image = UIImage(data: imageData) ?? UIImage()
                
                cell.setup(title: movie.title,
                           year:"\(movie.releaseDate.prefix(4))",
                           image: image)
                
                
            }
            
            return cell
        }
        return NowPlayingCollectionViewCell()
    }
    
    
    fileprivate func makePopularCell(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "popularCell", for: indexPath) as? PopularCollectionViewCell {
            
            cell.setup(title: popularMovies[indexPath.item].title,
                       image: UIImage())
            let movie = popularMovies[indexPath.item]
            
            Task {
                let imageData = await Movie.downloadImageData(withPath:
                                                                movie.backdropPath)
                let imagem = UIImage (data: imageData) ?? UIImage()
                
                cell.setup(title: movie.title, image: imagem)
            }
            
            return cell
        }
        return UICollectionViewCell()
        
    }
    
    fileprivate func upcomingCell(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcomingCell", for: indexPath) as? UpcomingCollectionViewCell {
            let movie = upcomingMovies [indexPath.item] // indexPath = ??ndice do filme
            cell.setup(title: upcomingMovies[indexPath.item].title, year: "\(movie.releaseDate.prefix(4))",
                       image: UIImage())
            Task {
                let imageData = await Movie.downloadImageData(withPath:
                                                                movie.posterPath) //poster ?? o formato da API que queremos, n??o backdrop
                let imagem = UIImage (data: imageData) ?? UIImage()
                
                cell.setup(title: movie.title, year: "\(movie.releaseDate.prefix(4))", image: imagem) //a informa????o do releasedate tem no site da API
            }
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == popularCollectionView {
            return makePopularCell(collectionView, indexPath)
        }
        else if collectionView == nowPlayingCollectionView {
            return makeNowPlayingCell(indexPath:indexPath)
        
        }
        else {
            return upcomingCell(collectionView, indexPath)
        }
    }
}
