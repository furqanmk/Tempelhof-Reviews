//
//  ReviewsDataProvider.swift
//  Tempelhof Reviews
//
//  Created by Furqan on 2019-05-24.
//  Copyright © 2019 Furqan. All rights reserved.
//

import Foundation

enum FetchError: Error {
    case invalidUrl
    case noData
    case parsingFailed
}

enum RequestPage {
    case first
    case next
}

final class ReviewsDataProvider {
    
    enum Result {
        case sucess([Review])
        case failure(Error)
    }
    
    private static let host = "www.getyourguide.com"
    private static let urlComponents = ["berlin-l17",
                                        "tempelhof-2-hour-airport-history-tour-berlin-airlift-more-t23776",
                                        "reviews.json"]
    private static var currentPage = 0
    
    /// Requests reviews.
    ///
    /// - Parameter onComplete: call back with a list of reviews.
    static func fetchReviews(for page: RequestPage, onComplete: @escaping (Result)->Void) {
        
        switch page {
        case .first:
            currentPage = 0
        case .next:
            currentPage += 1
        }
        
        let urlString = (["https://" + host] + urlComponents).joined(separator: "/")
        guard let url = URL(string: urlString) else {
            onComplete(.failure(FetchError.invalidUrl))
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Complete with generic error from response.
            if let error = error {
                onComplete(.failure(error))
                return
            }
            
            // Complete with error on data-less response.
            guard let data = data else {
                onComplete(.failure(FetchError.noData))
                return
            }
            
            let decoder = JSONDecoder()
            // Attempt decoding response.
            guard let reviewRequestResponse = try? decoder.decode(ReviewRequestResponse.self, from: data) else {
                onComplete(.failure(FetchError.parsingFailed))
                return
            }
            
            // Complete with successful parsing of data.
            onComplete(.sucess(reviewRequestResponse.data))
        }.resume()
    }
}
