//
//  ReviewsViewModel.swift
//  Tempelhof Reviews
//
//  Created by Furqan on 2019-05-24.
//  Copyright © 2019 Furqan. All rights reserved.
//

import Foundation

protocol ReviewsViewUIDelegate: class {
    func updated(state: ReviewViewState)
}

enum ReviewViewState {
    case fetching, fetched, failed(Error)
}

final class ReviewsViewModel {
    var uiDelegate: ReviewsViewUIDelegate?
    var reviews: [Review] = []
    
    private let onReviewSelected: (Review)->Void
    
    init(onReviewSelected: @escaping (Review)->Void) {
        self.onReviewSelected = onReviewSelected
    }
    
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
        
        uiDelegate?.updated(state: .fetching)
        
        ReviewsDataProvider.fetchReviews(for: page) { [weak self] result in
            let state: ReviewViewState
            switch result {
            case .sucess(let reviews):
                state = .fetched
                self?.reviews += reviews
                
            case .failure(let error):
                state = .failed(error)
            }
            
            DispatchQueue.main.async {
                self?.uiDelegate?.updated(state: state)
            }
        }
    }
}
