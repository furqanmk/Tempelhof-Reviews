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
        
        tableView.register(UINib(nibName: ReviewCell.className, bundle: nil), forCellReuseIdentifier: ReviewCell.className)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 102
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewCell.className, for: indexPath) as? ReviewCell else {
            return UITableViewCell()
        }
        cell.setup(with: viewModel.reviews[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if tableView.contentOffset.y >= (tableView.contentSize.height - tableView.frame.size.height) {
            viewModel.didReachPageEnd()
        }
    }
}

extension ReviewsViewController: ReviewsViewUIDelegate {
    
    func updated(state: ReviewViewState) {
        switch state {
        case .fetching:
            let indicatorFooter = UIActivityIndicatorView(frame: CGRect(origin: .zero,
                                                                        size: CGSize(width: tableView.bounds.width, height: 44)))
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
