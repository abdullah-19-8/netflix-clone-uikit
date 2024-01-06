//
//  Movie.swift
//  Netflix Clone
//
//  Created by Abdulla Ahmad on 1/6/24.
//

import Foundation

struct TrendingMovieResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let id: Int
    let media_type: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
}

/*
 adult = 0;
 "backdrop_path" = "/tFxAeagQbrjCqjikwvfsLf6ktT7.jpg";
 "genre_ids" =             (
     878,
     9648,
     53,
     18
 );
 id = 760245;
 "media_type" = movie;
 "original_language" = en;
 "original_title" = Foe;
 overview = "Henrietta and Junior farm a secluded piece of land that has been in Junior's family for generations, but their quiet life is thrown into turmoil when an uninvited stranger shows up at their door with a startling proposal. Will they risk their relationship & personal identity for a chance to survive in a new world?";
 popularity = "27.95";
 "poster_path" = "/eTPBizhkX6B9NgzPzkhVIOvwXxZ.jpg";
 "release_date" = "2023-10-06";
 title = Foe;
 video = 0;
 "vote_average" = "5.7";
 "vote_count" = 38;
 */
