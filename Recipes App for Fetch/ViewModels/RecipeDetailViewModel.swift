//
//  RecipeDetailViewModel.swift
//  Recipes App for Fetch
//
//  Created by Yunao Guo on 11/2/23.
//

import Combine
import SwiftUI

class RecipeDetailViewModel: ObservableObject {
    @Published var recipe: RecipeDetail?
    
    func loadRecipeDetails(recipeID: String) {
        Task {
            do {
                if let recipeDetail = try await RecipeDetailService.shared.getRecipeDetailsById(recipeID: recipeID) {
                    DispatchQueue.main.async {
                        self.recipe = recipeDetail
                    }
                }
            } catch {
                print("Error loading recipe details: \(error)")
            }
        }
    }
}
