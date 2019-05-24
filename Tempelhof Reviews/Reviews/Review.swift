//
//  Review.swift
//  Tempelhof Reviews
//
//  Created by Furqan on 2019-05-24.
//  Copyright © 2019 Furqan. All rights reserved.
//

import Foundation

enum TravelerType: String, Decodable {
    case couple, solo, friends, familyYoung
}

struct Review: Decodable {
    let reviewId: Int
    let rating: Double
    let title: String?
    let message: String?
    let author: String
    let foreignLanguage: Bool
    let date: Date
    let languageCode: String
    let travelerType: TravelerType?
    let reviewerName: String
    let reviewerCountry: String
    let reviewerProfilePhoto: String?
    let isAnonymous: Bool
    let firstInitial: String
}

struct ReviewRequestResponse: Decodable {
    let data: [Review]
}
