//
//  HomeViewModels.swift
//  RecipesApp-Fetch
//
//  Created by Yunao Guo on 10/31/23.
//

import SwiftUI

struct MealsResponse: Decodable {
    var meals: [Recipe]
}

enum RecipeSortOption {
    case alphabetical
    case reverseAlphabetical
}

class HomeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var sortOption: RecipeSortOption = .alphabetical
    @Published var selectedRecipe: Recipe?
    
    func fetchRecipes() {
        recipes = []
        
        if let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    if var decodedResponse = try? JSONDecoder().decode(MealsResponse.self, from: data) {
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
        sortRecipes()
    }
    
    func sortRecipes() {
        switch sortOption {
        case .alphabetical:
            recipes.sort { $0.strMeal < $1.strMeal }
        case .reverseAlphabetical:
            recipes.sort { $0.strMeal > $1.strMeal }
        }
    }
    
    func filteredRecipes(searchText: String) -> [Recipe] {
        if searchText.isEmpty {
            return recipes
        } else {
            return recipes.filter { $0.strMeal.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    func onRecipeSelected(recipe: Recipe) {
        selectedRecipe = recipe
    }
}
