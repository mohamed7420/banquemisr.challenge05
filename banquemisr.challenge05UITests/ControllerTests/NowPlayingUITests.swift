//
//  NowPlayingUITests.swift
//  banquemisr.challenge05UITests
//
//  Created by Mohamed Osama on 05/05/2024.
//

import XCTest
@testable import banquemisr_challenge05

class NowPlayingViewControllerUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testMovieSelection() throws {
        let firstMovieCell = app.collectionViews.cells.element(boundBy: 0)
        XCTAssertTrue(firstMovieCell.waitForExistence(timeout: 5))
        firstMovieCell.tap()
        
        XCTAssertFalse(app.navigationBars["Movie Details"].waitForExistence(timeout: 5))
    }
}
