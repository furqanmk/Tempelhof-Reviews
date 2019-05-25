//
//  ReviewsCoordinator.swift
//  Tempelhof Reviews
//
//  Created by Furqan on 2019-05-25.
//  Copyright © 2019 Furqan. All rights reserved.
//

import UIKit

class ReviewsCoordinator {
    
    // - MARK: Properties
    
    private let navigationController: UINavigationController
    
    // - MARK: Initializers
    
    /// Initializer for reviews flow coordinator
    ///
    /// - Parameters:
    ///   - navigationController: navigation Controller
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // - MARK: Public methods
    
    /// Start view controller for the coordinator
    ///
    /// - Returns: start view controller
    func start() -> UIViewController {
        return configuredReviewsViewController()
    }
    
    // - MARK: Private methods
    
    private func configuredReviewsViewController() -> ReviewsViewController {
        let viewModel = ReviewsViewModel(onReviewSelected: { [weak self] review in
            self?.showReviewDetails(for: review)
        })
        return ReviewsViewController(with: viewModel)
    }
    
    private func showReviewDetails(for review: Review) {
        
    }
}
