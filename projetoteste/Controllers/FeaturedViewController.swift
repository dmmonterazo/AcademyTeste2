//
//  FeaturedViewController.swift
//  projetoteste
//
//  Created by dmm on 04/07/22.
//

import UIKit

class FeaturedViewController: UIViewController {
    
    var popularMovies : [Movie] = [] //Recebe uma lista vazia do tipo movie que será preenchida pela API
    var topRatedMovies : [Movie] = [] //Recebe uma lista vazia do tipo movie que será preenchida pela API
    let upcomingMovies = Movie.upcomingMovies() //aqui já temos a informação no computador mas estamos baixando novas inormações
    

    @IBOutlet var popularCollectionView: UICollectionView!
    @IBOutlet var nowPlayingCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        popularCollectionView.dataSource = self
        nowPlayingCollectionView.dataSource = self
        
        popularCollectionView.delegate = self
        nowPlayingCollectionView.delegate = self
        
        Task {
            self.popularMovies = await Movie.popularMoviesAPI()
        self.popularCollectionView.reloadData()
        }
        
        Task {
            self.topRatedMovies = await Movie.topRatedAPI()
            self.nowPlayingCollectionView.reloadData ()
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue,
        sender: Any?) {
        //passar filme adiante
        if let destination = segue.destination as? DetailsViewController{
            let movie = sender as? Movie
            destination.movie = movie
        }
        }
    }

