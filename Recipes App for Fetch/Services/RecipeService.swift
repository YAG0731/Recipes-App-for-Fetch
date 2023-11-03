//
//  RecipeService.swift
//  Recipes App for Fetch
//
//  Created by Yunao Guo on 11/2/23.
//

import Foundation
import Combine

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case decodingFailed
    case noData
}


class RecipeService {
    static let shared = RecipeService()
    
    private init() {}

    func getRecipes(completion: @escaping (Result<[Recipe], Error>) -> Void) {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let mealsResponse = try decoder.decode(MealsResponse.self, from: data!)
                completion(.success(mealsResponse.meals))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

