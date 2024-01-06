//
//  APICaller.swift
//  Netflix Clone
//
//  Created by Abdulla Ahmad on 1/6/24.
//

import Foundation

struct Constant {
    static let API_KEY = "059cd5bcf9c4e5431b4f5a8d3fc77ff5"
    static let baseURL = "https://api.themoviedb.org"
}

enum APIError: Error {
    case failedToGetData
}

class APICaller {
    static let shared = APICaller()
    
    
    func getTreandingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        
        guard let url = URL(string: "\(Constant.baseURL)/3/trending/movie/day?api_key=\(Constant.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do{
                let results = try JSONDecoder().decode(TrendingMovieResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
