//
//  MovieTableViewCell.swift
//  MovieSearch
//
//  Created by Greg Hughes on 12/14/18.
//  Copyright © 2018 Greg Hughes. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    var movies : Movies?{
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    
    
     func updateViews(){
        
         guard let movie = movies else {return}
        
        MovieController.fetchImage(movie: movie) { (image) in
            
            DispatchQueue.main.async {
                self.titleLabel.text = movie.title
                self.ratingLabel.text = "\(movie.rating)"
                self.overviewLabel.text = movie.overview
                self.movieImage.image = image
                
            }
        }
    }
}
