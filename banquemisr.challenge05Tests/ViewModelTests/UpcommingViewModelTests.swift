//
//  UpcommingViewModelTests.swift
//  banquemisr.challenge05Tests
//
//  Created by Mohamed Osama on 05/05/2024.
//

import XCTest
@testable import banquemisr_challenge05

class UpcommingViewModelTests: XCTestCase {
    
    class MockNetworkService: NetworkService {
        override func request<T>(path: Endpoint, parameters: [String : String]?) async throws -> T where T : Decodable {
            // Simulate a response
            let response = PopularMovieResponse(results: [Movie(adult: true, backdropPath: "/hu40Uxp9WtpL34jv3zyWLb5zEVY.jpg", genreIDS: [16, 28, 10751, 35, 14], id: 1011985, originalLanguage: "en", originalTitle: "Kung Fu Panda 4", overview: "Po is gearing up to become the spiritual leader of his Valley of Peace, but also needs someone to take his place as Dragon Warrior. As such, he will train a new kung fu practitioner for the spot and will encounter a villain called the Chameleon who conjures villains from the past.", popularity: 1230.013, posterPath: "/kDp1vUBnMpe8ak4rjgl3cLELqjU.jpg", releaseDate: "2024-03-02", title: "Kung Fu Panda 4", video: true, voteAverage: 7.13, voteCount: 1482)])
            return response as! T
        }
    }
    
    var viewModel: UpcommingViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = UpcommingViewModel()
        
        // Inject the mock network service
        viewModel.manager = MockNetworkService()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testLoadPopularMovies() {
        let expectation = XCTestExpectation(description: "Loading popular movies")
        
        Task {
            do {
                _ = try await viewModel.loadUpcommingMovies()
                XCTAssertFalse(viewModel.isLoading)
                XCTAssertEqual(viewModel.movies.count, 1)
                XCTAssertEqual(viewModel.movies.first?.title, "Kung Fu Panda 4")
                expectation.fulfill()
            } catch {
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testSelectedMovie() {
        viewModel.movies = [Movie(adult: true, backdropPath: "/hu40Uxp9WtpL34jv3zyWLb5zEVY.jpg", genreIDS: [16, 28, 10751, 35, 14], id: 1011985, originalLanguage: "en", originalTitle: "Kung Fu Panda 4", overview: "Po is gearing up to become the spiritual leader of his Valley of Peace, but also needs someone to take his place as Dragon Warrior. As such, he will train a new kung fu practitioner for the spot and will encounter a villain called the Chameleon who conjures villains from the past.", popularity: 1230.013, posterPath: "/kDp1vUBnMpe8ak4rjgl3cLELqjU.jpg", releaseDate: "2024-03-02", title: "Kung Fu Panda 4", video: true, voteAverage: 7.13, voteCount: 1482)]
        
        let selectedMovie = viewModel.selectedMovie(at: 0)
        
        XCTAssertEqual(selectedMovie?.originalTitle, "Kung Fu Panda 4")
    }
}
