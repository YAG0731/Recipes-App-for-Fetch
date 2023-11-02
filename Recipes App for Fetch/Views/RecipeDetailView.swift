//
//  RecipeDetailView.swift
//  Recipes App for Fetch
//
//  Created by Yunao Guo on 11/2/23.
//

import SwiftUI

struct RecipeDetailView: View {
    @ObservedObject var viewModel: RecipeDetailViewModel

    init(recipeID: String) {
        self.viewModel = RecipeDetailViewModel(recipeID: recipeID)
    }

    var body: some View {
        if let recipe = viewModel.recipe {
            ScrollView {
                VStack {
                    // Display recipe details here
                    Text("Recipe Name: \(recipe.strMeal)")
                    Text("Instructions: \(recipe.strInstructions)")
                    
                    // Loop through ingredients and measurements
                    ForEach(0..<min(recipe.ingredients.count, recipe.measurements.count), id: \.self) { index in
                        Text("\(recipe.ingredients[index]): \(recipe.measurements[index])")
                    }

                    // You can add more UI elements to display other recipe details
                }
                .padding()
            }
            .navigationBarTitle("Recipe Details")
        } else {
            Text("Loading...")
        }
    }
}

//#Preview {
//    RecipeDetailView()
//}
