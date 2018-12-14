//
//  MovieTableViewController.swift
//  MovieSearch
//
//  Created by Greg Hughes on 12/14/18.
//  Copyright © 2018 Greg Hughes. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController {

    
    var movies : [Movies] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            
        }
        
        
        self.definesPresentationContext = true
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        self.navigationItem.searchController = searchController
    }

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieTableViewCell

        let movie = movies[indexPath.row]
        
        cell.movies = movie
        // Configure the cell...

        return cell
    }

}


extension MovieTableViewController: UISearchBarDelegate {
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchTerm = searchBar.text ?? ""
        self.definesPresentationContext = true
        MovieController.searchMovies(movie: searchTerm) { (movies) in
            
            
            guard let searchedMovies = movies else {return}
            
            self.movies = searchedMovies
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
