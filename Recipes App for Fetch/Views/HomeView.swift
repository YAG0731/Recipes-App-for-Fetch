//
//  HomeView.swift
//  RecipesApp-Fetch
//
//  Created by Yunao Guo on 10/31/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.recipes, id: \.idMeal) { recipe in
                    RecipeRow(recipe: recipe)
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.fetchRecipes()
        }
    }
}

