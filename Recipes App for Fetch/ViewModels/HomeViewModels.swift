//
//  HomeViewModels.swift
//  RecipesApp-Fetch
//
//  Created by Yunao Guo on 10/31/23.
//

import SwiftUI

enum RecipeSortOption {
    case alphabetical
    case reverseAlphabetical
}

class HomeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var sortOption: RecipeSortOption = .alphabetical
    @Published var selectedRecipe: Recipe?
    @Published var loading: Bool = false
    @Published var networkError: NetworkError? = nil
    @Published var searchText: String = ""
    
    func loadAllRecipes() {
        loading = true
        networkError = nil
        
        RecipeService.shared.getAllRecipes { result in
            DispatchQueue.main.async {
                self.loading = false
                
                switch result {
                case .success(let recipes):
                    self.recipes = recipes
                    self.sortRecipes()
                case .failure(_):
                    self.networkError = .requestFailed
                }
            }
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
