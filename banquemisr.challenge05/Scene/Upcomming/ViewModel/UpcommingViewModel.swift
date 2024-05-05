//
//  UpcommingViewModel.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Osama on 05/05/2024.
//

import Foundation
import Combine

class UpcommingViewModel {
    public var manager = NetworkService()
    private let storageManager = StorageManager.shared

    @Published var isLoading = true
    @Published var movies: [Movie] = []
    private var page: Int = 1
    
    @discardableResult
    func loadUpcommingMovies(page: Int = 1) async throws -> PopularMovieResponse {
        isLoading = true
        defer { isLoading = false }
        
        let response: PopularMovieResponse = try await manager.request(path: .upcomming, parameters: ["page": "\(page)"])
        movies = response.results
        storageManager.saveMovies(movies: movies)
        return response
    }
    
    func selectedMovie(at index: Int) -> Movie? {
        guard !movies.isEmpty else { return nil }
        
        return movies[index]
    }
}
