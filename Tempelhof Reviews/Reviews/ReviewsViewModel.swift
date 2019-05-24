//
//  ReviewsViewModel.swift
//  Tempelhof Reviews
//
//  Created by Furqan on 2019-05-24.
//  Copyright © 2019 Furqan. All rights reserved.
//

import Foundation

protocol ReviewsUIDelegate {
    func updateLoadingState(isLoading: Bool)
    func updateView()
}

class ReviewsViewModel {
    var uiDelegate: ReviewsUIDelegate?
    var reviews: [Review] = []
    
    /// To inform view model that view will appear.
    /// View model fetches the first page of reviews.
    func viewWillAppear() {
        reviews = []
        fetchReviews(for: .first)
    }
    
    /// To inform view model that list has been scrolled to the bottom.
    /// View model fetches the next page of reviews.
    func didReachPageEnd() {
        fetchReviews(for: .next)
    }
    
    private func fetchReviews(for page: RequestPage) {
        
        uiDelegate?.updateLoadingState(isLoading: true)
        
        ReviewsDataProvider.fetchReviews(for: page) { [weak self] result in
            switch result {
            case .sucess(let reviews):
                self?.reviews += reviews
                
            case .failure(let error):
                print("Handle error: \(error)")
            }
            
            self?.uiDelegate?.updateLoadingState(isLoading: false)
            self?.uiDelegate?.updateView()
        }
    }
}
