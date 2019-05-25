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
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.viewWillAppear()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.reviews.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let review = viewModel.reviews[indexPath.row]
        cell.textLabel?.text = review.author
        return cell
    }
    
}

extension ReviewsViewController: ReviewsViewUIDelegate {
    
    func updateLoadingState(isLoading: Bool) {
        
    }
    
    func updateView() {
        tableView.reloadData()
    }
    
}
