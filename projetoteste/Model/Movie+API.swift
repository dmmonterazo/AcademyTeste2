//
//  Movie+API.swift
//  FilmADA
//
//  Created by Francisco Soares Neto on 13/07/22.
//

import Foundation

extension Movie {
    
    //Download de populares
    
    static let urlComponents = URLComponents(string: "https://api.themoviedb.org/")! //Dá o endereço base
    
    static func popularMoviesAPI() async -> [Movie] {
        
        var components = Movie.urlComponents //urlComponents = o link que havia sido definido como urlComponents
        components.path = "/3/movie/popular" //É aqui a região onde quero fazer a busca pelo tipo de filme
        components.queryItems = [
            URLQueryItem(name: "api_key", value: Movie.apiKey) //api_key se refere à chave do API que foi gerada mas não vai pro github, no TMDB-info.plist
        ]
        
        let session = URLSession.shared
        
        do {
            
            let (data, response) = try await session.data(from:
                                                            components.url!)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let movieResult = try decoder.decode(MoviesResponse.self, from: data)
            
            return movieResult.results
            
            
        } catch {
            print(error)
        }
        return []
    }
    
    static func topRatedAPI() async -> [Movie] {
        var components = Movie.urlComponents
        components.path = "/3/movie/top_rated"
        components.queryItems = [
            URLQueryItem(name: "api_key", value: Movie.apiKey)
        ]
        
        let session = URLSession.shared
        do { let (data, response) = try await session.data(from:
                                                            components.url!)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let movieResult = try decoder.decode(MoviesResponse.self, from: data)
            
            return movieResult.results
        }catch{
            print(error)
        }
        return []
        
    }
    
    static func upcomingAPI() async -> [Movie] {
        var components = Movie.urlComponents
        components.path = "/3/movie/upcoming"
        components.queryItems = [
            URLQueryItem(name: "api_key", value: Movie.apiKey)
        ]
        
        let session = URLSession.shared
        do { let (data, response) = try await session.data(from:
                                                            components.url!)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let movieResult = try decoder.decode(MoviesResponse.self, from: data)
            
            return movieResult.results
        }catch{
            print(error)
        }
        return []
        
    }
    
    
    
    
    
    
    //MARK: - Download de imagens
    
    static func downloadImageData(withPath: String) async -> Data {
        let urlString = "https://image.tmdb.org/t/p/w780\(withPath)"
        let url: URL = URL(string: urlString)!
        let session = URLSession.shared
        
        do {
            let (data, response) = try await session.data(from:url)
            return data
        }catch{
            print(error)
        }
        return Data()
    }
    
    
    // MARK: - Recuperando a chave da API de um arquivo
    static var apiKey: String {
        guard let url = Bundle.main.url(forResource: "TMDB-Info", withExtension: "plist") else {
            fatalError("Couldn't find api key configuration file.")
        }
        guard let plist = try? NSDictionary(contentsOf: url, error: ()) else {
            fatalError("Couldn't interpret api key configuration file as plist.")
        }
        guard let key = plist["API_KEY"] as? String else {
            fatalError("Couldn't find an api key in its configuration file.")
        }
        return key
    }
}

