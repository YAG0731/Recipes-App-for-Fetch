//
//  HomeViewModels.swift
//  RecipesApp-Fetch
//
//  Created by Yunao Guo on 10/31/23.
//

import SwiftUI

struct MealsResponse: Decodable {
    var meals: [Meal]
}

enum RecipeSortOption {
    case alphabetical
    case reverseAlphabetical
}

class HomeViewModel: ObservableObject {
    @Published var recipes: [Meal] = []
    @Published var sortOption: RecipeSortOption = .alphabetical
    
    func fetchRecipes() {
        recipes = []
        
        if let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    if var decodedResponse = try? JSONDecoder().decode(MealsResponse.self, from: data) {
                        // Filter out any null or empty values and print them
                        decodedResponse.meals = decodedResponse.meals.filter { meal in
                            if meal.strMeal.isEmpty || meal.idMeal.isEmpty {
                                print("Null or empty value found: strMeal = \(meal.strMeal), idMeal = \(meal.idMeal)")
                                return false
                            }
                            return true
                        }
                        
                        DispatchQueue.main.async {
                            self.recipes = decodedResponse.meals
                            self.sortRecipes()
                        }
                        return
                    }
                }
                // Handle errors here, such as network or decoding errors
            }.resume()
        }
    }

    func toggleSortOrder() {
        switch sortOption {
        case .alphabetical:
            sortOption = .reverseAlphabetical
        case .reverseAlphabetical:
            sortOption = .alphabetical
        }
        fetchRecipes()
    }
    
    func sortRecipes() {
        switch sortOption {
        case .alphabetical:
            recipes.sort { $0.strMeal < $1.strMeal }
        case .reverseAlphabetical:
            recipes.sort { $0.strMeal > $1.strMeal }
        }
    }
    
    func sortRecipes(by sortOption: RecipeSortOption) {
        // Change the sorting option and sort the recipes based on the selected option.
        self.sortOption = sortOption
        sortRecipes()
    }
}
