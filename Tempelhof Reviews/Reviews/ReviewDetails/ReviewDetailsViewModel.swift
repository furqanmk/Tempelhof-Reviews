//
//  ReviewDetailsViewModel.swift
//  Tempelhof Reviews
//
//  Created by Furqan on 2019-05-25.
//  Copyright © 2019 Furqan. All rights reserved.
//

import Foundation

final class ReviewDetailsViewModel {
    
    // - MARK: Private properties
    
    private let review: Review
    
    // - MARK: Initializers
    
    /// Initializes view model for ReviewDetailsViewController
    ///
    /// - Parameter review: Instance of a review object.
    init(with review: Review) {
        self.review = review
    }
    
    // - MARK: Public properties
    
    var profileImageUrl: URL? {
        guard
            let imageUrlString = review.reviewerProfilePhoto,
            let url = URL(string: imageUrlString) else {
                return nil
        }
        return url
    }
    
    var name: String {
        return review.reviewerName
    }
    
    var country: String {
        return review.reviewerCountry
    }
    
    var title: String? {
        return review.title
    }
    
    var message: String? {
        return review.message
    }
    
    var rating: String {
        return review.rating
    }
    
    var travelerType: String {
        guard let travelerType = review.travelerType else {
            return ""
        }
        
        switch travelerType {
        case .couple:
            return "Couple"
        case .familyOld:
            return "Senior Family"
        case .familyYoung:
            return "Young Family"
        case .solo:
            return "Solo"
        case .friends:
            return "Friends"
        }
    }
    
    var date: String {
        return review.date
    }
    
    var firstInitial: String {
        return review.firstInitial
    }
    
}
