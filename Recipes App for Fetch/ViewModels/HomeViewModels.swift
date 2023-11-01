//
//  HomeViewModels.swift
//  RecipesApp-Fetch
//
//  Created by Yunao Guo on 10/31/23.
//

import SwiftUI

struct MealsResponse: Decodable {
    let meals: [Meal]
}

enum RecipeSortOption {
    case alphabetical
    case reverseAlphabetical
}

class HomeViewModel: ObservableObject {
    @Published var recipes: [Meal] = []
    @Published var sortOption: RecipeSortOption = .alphabetical

    func fetchRecipes() {
        // Clear the existing recipes.
        recipes = []

        var sortOptionParam: String
        switch sortOption {
            case .alphabetical:
                sortOptionParam = "name"
            case .reverseAlphabetical:
                sortOptionParam = "name"
        }

        if let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert&s=\(sortOptionParam)") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    if let decodedResponse = try? JSONDecoder().decode(MealsResponse.self, from: data) {
                        DispatchQueue.main.async {
                            self.recipes = decodedResponse.meals
                        }
                        return
                    }
                }
                // Handle errors here, such as network or decoding errors
            }.resume()
        }
    }

    func sortRecipes(by sortOption: RecipeSortOption) {
        // Change the sorting option and fetch recipes based on the selected option.
        self.sortOption = sortOption
        fetchRecipes()
    }
}
