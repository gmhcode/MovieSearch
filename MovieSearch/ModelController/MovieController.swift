//
//  MovieController.swift
//  MovieSearch
//
//  Created by Greg Hughes on 12/14/18.
//  Copyright © 2018 Greg Hughes. All rights reserved.
//

import Foundation
import UIKit

class MovieController {
    
    static let baseUrl = URL(string: "https://api.themoviedb.org/3/search/movie")
    
    
    
    static func searchMovies(movie: String, completion: @escaping ([Movies]?) -> Void) {
    
        guard let url = baseUrl else {completion(nil) ; return}
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let queryItem = URLQueryItem(name: "api_key", value: "7f5f4e6a07db6fb0937476aa3b1f48f1")
        let secondQueryItem = URLQueryItem(name: "query", value: movie.lowercased())
        
        components?.queryItems = [queryItem,secondQueryItem]
        
        guard let completeUrl = components?.url else {completion(nil) ; return}
        
        var request = URLRequest(url: completeUrl)
        request.httpBody = nil
        request.httpMethod = "GET"
        
        
        print(completeUrl)
        
        URLSession.shared.dataTask(with: request) { (data, reponse, error) in
            if let error = error {
                print("❌ There was an error in \(#function) \(error) : \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {completion(nil) ; return}
            
            do {
                
                let jsonDecoder = JSONDecoder()
                let resultDictionary = try jsonDecoder.decode(TopLevelDictionary.self, from: data)
                let result = resultDictionary.results
                
                completion(result)
            }
            catch{
                print("❌ There was an error in \(#function) \(error) : \(error.localizedDescription)")
                completion(nil)
            }
            
            
        }.resume()
//        api_key=7f5f4e6a07db6fb0937476aa3b1f48f1&query=star%20wars
        
    }
    
    
    
    static func fetchImage(movie: Movies, completion: @escaping (UIImage?) -> Void) {
        
        let baseImageUrl =  "https://image.tmdb.org/t/p/original"
        
        guard let posterImage = movie.posterImage else {completion(nil) ; return}
        let imageUrlExtension = baseImageUrl + posterImage 
        
        guard let fullUrl = URL(string: imageUrlExtension) else {completion(nil) ; return}
        
        URLSession.shared.dataTask(with: fullUrl) { (imageData, _, error) in
            if let error = error {
                print("❌ There was an error in \(#function) \(error) : \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            
            guard let imageData = imageData else { completion(nil) ; return}
            
            guard let movieImage = UIImage(data: imageData) else {completion(nil) ; return}
            
            completion(movieImage)
            
        }.resume()
        
    }
}



    
    
    
    

