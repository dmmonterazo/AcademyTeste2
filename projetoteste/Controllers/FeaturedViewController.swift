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
    var upcomingMovies : [Movie] = [] //aqui já temos a informação no computador mas estamos baixando novas inormações
    

    @IBOutlet var popularCollectionView: UICollectionView!
    @IBOutlet var nowPlayingCollectionView: UICollectionView!
    @IBOutlet var upcomingCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        popularCollectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        
        nowPlayingCollectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        
        upcomingCollectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)



        popularCollectionView.dataSource = self
        popularCollectionView.delegate = self
       
        nowPlayingCollectionView.dataSource = self
        nowPlayingCollectionView.delegate = self
       
        
        upcomingCollectionView.delegate = self
        upcomingCollectionView.dataSource = self
    
        
        Task {
            self.popularMovies = await Movie.popularMoviesAPI()
        self.popularCollectionView.reloadData()
        }
        
        Task {
            self.topRatedMovies = await Movie.topRatedAPI()
            self.nowPlayingCollectionView.reloadData ()
        }
        
        Task {
            self.upcomingMovies = await Movie.upcomingAPI()
        self.upcomingCollectionView.reloadData()
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

