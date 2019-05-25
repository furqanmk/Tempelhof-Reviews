//
//  ReviewCell.swift
//  Tempelhof Reviews
//
//  Created by Furqan on 2019-05-25.
//  Copyright © 2019 Furqan. All rights reserved.
//

import UIKit
import SDWebImage

class ReviewCell: UITableViewCell {

    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        roundifyProfileImageView()
    }
    
    /// Sets up the UI of the cell using review.
    ///
    /// - Parameter review: Instance of `Review` object.
    func setup(with review: Review) {
        titleLabel.text = review.title
        messageLabel.text = review.message
        ratingLabel.text = review.rating
        
        if
            let imageUrlString = review.reviewerProfilePhoto,
            let imageUrl = URL(string: imageUrlString) {
                profileImageView.sd_setImage(with: imageUrl)
        } else {
            profileImageView.setImage(string: review.firstInitial,
                                      color: .random,
                                      circular: true,
                                      textAttributes: nil)
        }
        
    }
    
    /// Makes the shape of the profile image view circular.
    private func roundifyProfileImageView() {
        let dimension = min(profileImageView.frame.width, profileImageView.frame.height)
        profileImageView.layer.cornerRadius = dimension / 2
        profileImageView.layer.masksToBounds = true
    }
    
}
