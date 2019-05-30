//
//  ReviewsViewModelTests.swift
//  Tempelhof ReviewsTests
//
//  Created by Furqan on 2019-05-24.
//  Copyright © 2019 Furqan. All rights reserved.
//

import XCTest
@testable import Tempelhof_Reviews

class ReviewsViewModelTests: XCTestCase {
    
    private var uiDelegate: ReviewsViewUIDelegateMock!
    private var viewModel: ReviewsViewModel!
    private var onReviewSelectedCalled = false
    
    override func setUp() {
        super.setUp()
        
        setupObjects()
    }
    
    func testFetchSuccessful() {
        let expectation = self.expectation(description: "Fetch")
        uiDelegate.expectation = expectation
        ReviewsDataProviderMock.shouldSucceed = true
        viewModel.viewDidLoad()
        
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertTrue(uiDelegate.fetchSuccessful)
    }
    
    func testFetchFailed() {
        let expectation = self.expectation(description: "Fetch")
        uiDelegate.expectation = expectation
        ReviewsDataProviderMock.shouldSucceed = false
        viewModel.viewDidLoad()
        
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertFalse(uiDelegate.fetchSuccessful)
    }
    
    private func setupObjects() {
        self.uiDelegate = ReviewsViewUIDelegateMock()
        
        onReviewSelectedCalled = false
        let onReviewSelected: (Review)->() = { [weak self] response in
            self?.onReviewSelectedCalled = true
        }
        
        viewModel = ReviewsViewModel(dataProvider: ReviewsDataProviderMock.self,
                                     onReviewSelected: onReviewSelected)
        viewModel.uiDelegate = uiDelegate
    }
}

class ReviewsDataProviderMock: ReviewsDataProvider {
    static var shouldSucceed = true
    
    override class func fetchReviews(for page: RequestPage, onComplete: @escaping (Result)->Void) {
        if shouldSucceed {
            onComplete(.sucess([Review(reviewId: 0,
                                       rating: "",
                                       title: nil,
                                       message: nil,
                                       date: "",
                                       travelerType: nil,
                                       reviewerName: "",
                                       reviewerCountry: "",
                                       reviewerProfilePhoto: nil,
                                       firstInitial: "")]))
        } else {
            onComplete(.failure(NSError()))
        }
    }
}

class ReviewsViewUIDelegateMock: ReviewsViewUIDelegate {
    var expectation: XCTestExpectation!
    var fetchSuccessful: Bool!
    
    func updated(state: ClientState) {
        switch state {
        case .fetched:
            fetchSuccessful = true
            expectation.fulfill()
        case .failed(_):
            fetchSuccessful = false
            expectation.fulfill()
        default:
            return
        }
    }
}

