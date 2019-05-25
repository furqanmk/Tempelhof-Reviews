//
//  ReviewsViewController.swift
//  Tempelhof Reviews
//
//  Created by Furqan on 2019-05-24.
//  Copyright © 2019 Furqan. All rights reserved.
//

import UIKit

class ReviewsViewController: UITableViewController {
    
    private let viewModel: ReviewsViewModel
    private let reviewCellReuseId = "ReviewCell"
    
    init(with viewModel: ReviewsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.uiDelegate = self
        viewModel.viewDidLoad()
        
        // Set the title on the navigation bar
        title = "Tempelhof Reviews"
        // Register ReviewCell nib on the tableView
        tableView.register(UINib(nibName: ReviewCell.className, bundle: nil),
                           forCellReuseIdentifier: ReviewCell.className)
        // Enable automatic height on cells
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.reviews.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewCell.className, for: indexPath) as? ReviewCell else {
            return UITableViewCell()
        }
        cell.setup(with: viewModel.reviews[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectReview(at: indexPath.row)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Detects when user scrolls to the bottom of the table view
        if tableView.contentOffset.y >= (tableView.contentSize.height - tableView.frame.size.height) {
            viewModel.didReachPageEnd()
        }
    }
    
}

extension ReviewsViewController: ReviewsViewUIDelegate {
    
    func updated(state: ReviewViewState) {
        switch state {
        case .fetching:
            let activityIndicatorFrame = CGRect(origin: .zero, size: CGSize(width: tableView.bounds.width, height: 44))
            let indicatorFooter = UIActivityIndicatorView(frame: activityIndicatorFrame)
            indicatorFooter.color = .gray
            indicatorFooter.startAnimating()
            tableView.tableFooterView = indicatorFooter
        case .fetched:
            tableView.reloadData()
            tableView.tableFooterView = nil
        case .failed(let error):
            present(UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert),
                    animated: true)
            tableView.tableFooterView = nil
        }
    }
    
}
