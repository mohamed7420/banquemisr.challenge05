//
//  PopularViewModel.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Osama on 05/05/2024.
//

import Foundation

class PopularViewModel {
    public var manager = NetworkService()
    private let storageManager = StorageManager.shared

    @Published var isLoading = true
    @Published var movies: [Movie] = []
    
    @discardableResult
    func loadPopularMovies(page: Int = 1) async throws -> PopularMovieResponse {
        isLoading = true
        defer { isLoading = false }
        
        let response: PopularMovieResponse = try await manager.request(path: .popular, parameters: ["page": "\(page)"])
        movies = response.results
        storageManager.saveMovies(movies: movies)
        return response
    }
    
    func selectedMovie(at index: Int) -> Movie? {
        guard !movies.isEmpty else { return nil }
        
        return movies[index]
    }
}
