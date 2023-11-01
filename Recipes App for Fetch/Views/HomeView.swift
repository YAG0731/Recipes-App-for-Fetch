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
                Section() {
                    HStack {
                        Text("Desserts")
                        Spacer()
                        Image(viewModel.sortOption == .alphabetical ? "icons8-alphabetical-sorting-2-72(@3×)" : "icons8-sort-72(@3×)")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .onTapGesture {
                                viewModel.toggleSortOrder()
                            }
                        
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


