//
//  HomeViewModels.swift
//  RecipesApp-Fetch
//
//  Created by Yunao Guo on 10/31/23.
//

import SwiftUI
import Combine

enum RecipeSortOption {
    case alphabetical
    case reverseAlphabetical
}

@MainActor
class HomeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var displayedRecipes: [Recipe] = [] // Initial recipes to display
    @Published var sortOption: RecipeSortOption = .alphabetical
    @Published var selectedRecipe: Recipe?
    @Published var loading: Bool = false
    @Published var networkError: NetworkError? = nil
    @Published var searchText: String = ""

    init() {
        loadInitialRecipes()
    }

    func loadInitialRecipes() {
        loading = true
        networkError = nil

        Task {
            do {
                if let recipes = try await RecipeService.shared.getAllRecipes() {
                    self.recipes = recipes
                    
                    displayedRecipes = Array(recipes.prefix(8)) 
                    sortRecipes()// Display the first 8 recipes
                    loading = false
                } else {
                    networkError = .requestFailed
                    loading = false
                }
            } catch {
                networkError = .requestFailed
                loading = false
                print("Error loading recipes: \(error)")
            }
        }
    }
    
    func loadMoreRecipes() {
        if let lastDisplayedRecipeIndex = displayedRecipes.lastIndex(of: displayedRecipes.last ?? Recipe(idMeal: "", strMeal: "", strMealThumb: "")),
               lastDisplayedRecipeIndex < recipes.count - 1 {
                // Determine how many more recipes to load, e.g., 8 more
                let endIndex = min(lastDisplayedRecipeIndex + 8, recipes.count)
                let moreRecipes = recipes[(lastDisplayedRecipeIndex + 1)...endIndex]
                displayedRecipes.append(contentsOf: moreRecipes)
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
