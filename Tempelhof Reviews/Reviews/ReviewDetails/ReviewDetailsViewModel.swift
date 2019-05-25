//
//  ReviewDetailsViewModel.swift
//  Tempelhof Reviews
//
//  Created by Furqan on 2019-05-25.
//  Copyright © 2019 Furqan. All rights reserved.
//

import Foundation

final class ReviewDetailsViewModel {
    
    private let review: Review
    
    /// Initializes view model for ReviewDetailsViewController
    ///
    /// - Parameter review: Instance of a review object.
    init(with review: Review) {
        self.review = review
    }
}
