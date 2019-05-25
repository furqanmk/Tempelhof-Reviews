//
//  ReviewDetailsViewController.swift
//  Tempelhof Reviews
//
//  Created by Furqan on 2019-05-25.
//  Copyright © 2019 Furqan. All rights reserved.
//

import UIKit
import SDWebImage

class ReviewDetailsViewController: UIViewController {
    
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var countryLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var travelerTypeLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    private let viewModel: ReviewDetailsViewModel
    
    /// Initalizes view controller with an instance of view model.
    ///
    /// - Parameter viewModel: Instance of ReviewDetailsViewModel.
    init(viewModel: ReviewDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Review Details"
        setupUI()
    }

    /// Assigns values to UI elements from the view model.
    private func setupUI() {
        nameLabel.text = viewModel.name
        countryLabel.text = viewModel.country
        titleLabel.text = viewModel.title
        messageLabel.text = viewModel.message
        ratingLabel.text = viewModel.rating
        travelerTypeLabel.text = viewModel.travelerType
        dateLabel.text = viewModel.date
        
        if let profileImageUrl = viewModel.profileImageUrl {
            profileImageView.sd_setImage(with: profileImageUrl)
        } else {
            profileImageView.setImage(string: viewModel.firstInitial,
                                      color: .random,
                                      circular: true,
                                      textAttributes: nil)
        }
        roundifyProfileImageView()
    }
    
    /// Makes the shape of the profile image view circular.
    private func roundifyProfileImageView() {
        let dimension = min(profileImageView.frame.width, profileImageView.frame.height)
        profileImageView.layer.cornerRadius = dimension / 2
        profileImageView.layer.masksToBounds = true
    }
    
}
