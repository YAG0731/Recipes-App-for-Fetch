//
//  RecipeDetailViewModel.swift
//  Recipes App for Fetch
//
//  Created by Yunao Guo on 11/2/23.
//

import Foundation

class RecipeDetailViewModel: ObservableObject {
    @Published var recipe: RecipeDetail?
    private let recipeID: String

    init(recipeID: String) {
        self.recipeID = recipeID
        fetchRecipeDetails()
    }

    func fetchRecipeDetails() {
        if let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(recipeID)") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    if let decodedResponse = try? JSONDecoder().decode(RecipeResponse.self, from: data) {
                        if let recipeDetail = decodedResponse.meals.first {
                            DispatchQueue.main.async {
                                self.recipe = recipeDetail
                            }
                            return
                        }
                    }
                }
                // Handle errors here, such as network or decoding errors
            }.resume()
        }
    }
}
