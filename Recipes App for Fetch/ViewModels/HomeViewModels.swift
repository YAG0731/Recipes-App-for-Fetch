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
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchRecipes() {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: MealsResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
            }, receiveValue: { mealsResponse in
                self.recipes = mealsResponse.meals
                self.sortRecipes()
            })
            .store(in: &cancellables)
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
