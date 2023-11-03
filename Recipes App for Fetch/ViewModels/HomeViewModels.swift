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

class HomeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var sortOption: RecipeSortOption = .alphabetical
    @Published var selectedRecipe: Recipe?
    @Published var loading: Bool = false
    @Published var networkError: NetworkError? = nil
    @Published var searchText: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    func loadAllRecipes() {
        loading = true
        networkError = nil
        
        Task {
            do {
                if let recipes = try await RecipeService.shared.getAllRecipes() {
                    await MainActor.run {
                        self.recipes = recipes
                        self.sortRecipes()
                        self.loading = false
                    }
                } else {
                    await MainActor.run {
                        self.networkError = .requestFailed
                        self.loading = false
                    }
                }
            } catch {
                await MainActor.run {
                    self.networkError = .requestFailed
                    self.loading = false
                    print("Error loading recipes: \(error)")
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
