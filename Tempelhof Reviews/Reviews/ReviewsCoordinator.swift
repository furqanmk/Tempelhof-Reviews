//
//  ReviewsCoordinator.swift
//  Tempelhof Reviews
//
//  Created by Furqan on 2019-05-25.
//  Copyright © 2019 Furqan. All rights reserved.
//

import UIKit

final class ReviewsCoordinator {
    
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
    
    /// Creates a configured instance of ReviewsViewController.
    ///
    /// - Returns: Instance of ReviewsViewController
    private func configuredReviewsViewController() -> ReviewsViewController {
        let viewModel = ReviewsViewModel(onReviewSelected: { review in
            self.showReviewDetails(for: review)
        })
        return ReviewsViewController(with: viewModel)
    }
    
    /// Creates a configured instance of ReviewDetailsViewController
    /// and pushes it to the navigation controller.
    ///
    /// - Parameter review: Instance of review to configure the view controller with
    private func showReviewDetails(for review: Review) {
        let viewModel = ReviewDetailsViewModel(with: review)
        let viewController = ReviewDetailsViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
