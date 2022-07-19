//
//  DetailsViewController.swift
//  projetoteste
//
//  Created by dmm on 13/07/22.
//

import UIKit

class DetailsViewController: UIViewController {
    var movie: Movie?

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var backdropImage: UIImageView!
    @IBOutlet var posterImage: UIImageView!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        guard let movie = movie else{
            return
        }
        self.title = movie.title
        
        Task {
            let imageBackdropData = await Movie.downloadImageData(withPath: movie.backdropPath)
            
            let imagePosterData = await Movie.downloadImageData(withPath: movie.posterPath)
            
            let imagemFundo = UIImage(data: imageBackdropData) ?? UIImage()
            let imagemPoster = UIImage(data: imagePosterData) ?? UIImage()
            
            self.backdropImage.image = imagemFundo //UIImage(named: movie.backdropPath)
            
            self.posterImage.image = imagemPoster //UIImage(named: movie.backdropPath)

        }
        
        titleLabel.text = movie.title
        posterImage.image = UIImage(named: movie.posterPath)
        ratingLabel.text = "Rating:\(movie.voteAverage)/10"
        overviewLabel.text = movie.overview
    

    }

}
