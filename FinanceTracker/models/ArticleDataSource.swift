//
//  Article.swift
//  FinanceTracker
//
//  Created by נדב אבנון on 14/02/2021.
//

import Foundation


class ArticleDataSource {
    var apiKey = "ee6f740f76c14d7d895cdacea55779cb"
     func loadArticles(completion: @escaping (String?, ArticlesAPIResult?) -> Void) {
        var components = URLComponents()
        // url components
        components.scheme = "https"
        components.host = "newsapi.org"
        components.path = "/v2/top-headlines"
        // url query items
        let queryItemCountry = URLQueryItem(name: "country", value: "us")
        let queryItemApiKey = URLQueryItem(name: "apiKey", value: apiKey)
        components.queryItems = [queryItemCountry,queryItemApiKey]
        guard let url = components.url else {
            completion("[loadArticles] Could not load url", nil)
            return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion("[loadArticles] Could not data from dataTask: \(error.localizedDescription)", nil)
                return
            }
            if let data = data {
                let decoder = JSONDecoder()
                do {
                  let result = try decoder.decode(ArticlesAPIResult.self, from: data)
                    completion(nil,result)
                }catch let err {
                    completion("[loadArticles] Could not parse json from data: \(err.localizedDescription)", nil)
                }
            }
        }.resume()
    }
}


struct Article : Codable {
    var author:String?
    var title:String?
    var description:String?
    var urlToImage:String?
    var publishedAt:String?
    var content:String?
}

struct ArticlesAPIResult : Codable {
    var status:String?
    var totalResults:Int?
    var articles:[Article]?
}
