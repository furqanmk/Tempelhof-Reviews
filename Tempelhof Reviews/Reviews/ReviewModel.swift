//
//  ReviewModel.swift
//  Tempelhof Reviews
//
//  Created by Furqan on 2019-05-24.
//  Copyright © 2019 Furqan. All rights reserved.
//

import Foundation

enum TravelerType: String, Decodable {
    case couple
    case solo
    case friends
    case familyYoung = "family_young"
    case familyOld = "family_old"
}

struct Review: Decodable {
    let reviewId: Int
    let rating: String
    let title: String?
    let message: String?
    let date: String
    let travelerType: TravelerType?
    let reviewerName: String
    let reviewerCountry: String
    let reviewerProfilePhoto: String?
    let firstInitial: String
    
    private enum CodingKeys: String, CodingKey {
        case reviewId = "review_id"
        case rating
        case title
        case message
        case date
        case travelerType = "traveler_type"
        case reviewerName
        case reviewerCountry
        case reviewerProfilePhoto
        case firstInitial
    }
}

struct ReviewRequestResponse: Decodable {
    let data: [Review]
}
