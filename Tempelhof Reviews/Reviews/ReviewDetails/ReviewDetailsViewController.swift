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
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var travelerTypeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    private let viewModel: ReviewDetailsViewModel
    
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
    
    private func roundifyProfileImageView() {
        let dimension = min(profileImageView.frame.width, profileImageView.frame.height)
        profileImageView.layer.cornerRadius = dimension / 2
        profileImageView.layer.masksToBounds = true
    }
}
