//
//  MovieDetailsViewModel.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Osama on 05/05/2024.
//

import Foundation

class MovieDetailsViewModel {
    private let config = ConfigurationManager.shared
    
    private let movie: Movie
    init(movie: Movie) {
        self.movie = movie
    }
    
    var title: String {
        return movie.title
    }
    
    var overview: String {
        return movie.overview
    }
    
    var genreIds: String {
        return "Genre Ids: " + movie.genreIDS.map { "\($0)" }.joined(separator: ",")
    }
    
    var releaseDate: String {
        return "Release Date: " + movie.releaseDate
    }
    
    var imageURL: String {
        if let imageURL = try? config.xconfigValue(key: .imageURL) {
            return  "\(imageURL)" + (movie.backdropPath ?? "")
        }
        return ""
    }
}
