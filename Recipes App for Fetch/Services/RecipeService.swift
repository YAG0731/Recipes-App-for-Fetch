//
//  RecipeService.swift
//  Recipes App for Fetch
//
//  Created by Yunao Guo on 11/2/23.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case decodingFailed
    case noData
}

protocol RecipeServiceProtocol {
    func getAllRecipes() async throws -> [Recipe]?
}

class RecipeService: RecipeServiceProtocol {
    static let shared = RecipeService()

    private init() {}

    func getAllRecipes() async throws -> [Recipe]? {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            throw NetworkError.invalidURL
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let mealsResponse = try decoder.decode(MealsResponse.self, from: data)
            return mealsResponse.meals
        } catch {
            throw error
        }
    }
}


