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
        NavigationView {
            List {
                Section(header: Text("Sort Recipes")) {
                    Button(action: {
                        viewModel.sortRecipes(by: .alphabetical)
                    }) {
                        Text("Alphabetical Order")
                    }

                    Button(action: {
                        viewModel.sortRecipes(by: .reverseAlphabetical)
                    }) {
                        Text("Reverse Alphabetical Order")
                    }
                }

                Section(header: Text("Recipes")) {
                    ForEach(viewModel.recipes, id: \.idMeal) { recipe in
                        RecipeRow(recipe: recipe)
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .onAppear {
                viewModel.fetchRecipes()
            }
            .navigationBarTitle("Recipes")
        }
    }
}

