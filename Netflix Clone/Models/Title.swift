//
//  Movie.swift
//  Netflix Clone
//
//  Created by Abdulla Ahmad on 1/6/24.
//

import Foundation

struct TrendingTitleResponse: Codable {
    let results: [Title]
}

struct Title: Codable {
    let id: Int
    let media_type: String?
    let title: String?
    let poster_path: String?
    let original_name: String?
    let original_title: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
}
