//
//  RecipeDetailService.swift
//  Recipes App for Fetch
//
//  Created by Yunao Guo on 11/2/23.
//

import Foundation

final class RecipeDetailService {
    static let shared = RecipeDetailService()
    private init() { }
    
    func getRecipeDetailsById(recipeID: String) async throws -> RecipeDetail? {
        let urlString = "https://themealdb.com/api/json/v1/1/lookup.php?i=\(recipeID)"
        if let url = URL(string: urlString) {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decoder = JSONDecoder()
                let response = try decoder.decode(RecipeResponse.self, from: data)
                return response.meals.first
            } catch {
                print("Error fetching recipe details: \(error)")
                return nil
            }
        }
        return nil
    }
}
