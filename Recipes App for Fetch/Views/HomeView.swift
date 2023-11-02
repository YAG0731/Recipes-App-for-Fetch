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
                        NavigationLink(destination: RecipeDetailView(recipeID: recipe.idMeal)) {
                            HStack {
                                Spacer()
                                RecipeRow(recipe: recipe)
                                Spacer()
                            }
                        }
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

#Preview {
    let sampleRecipes: [Recipe] = [
        Recipe(idMeal: "1", strMeal: "Sample Recipe 1", strMealThumb: "sample-image-1"),
        Recipe(idMeal: "2", strMeal: "Sample Recipe 2", strMealThumb: "sample-image-2"),
        Recipe(idMeal: "3", strMeal: "Sample Recipe 3", strMealThumb: "sample-image-3")
    ]
    
    let viewModel = HomeViewModel()
    viewModel.recipes = sampleRecipes
    
    return HomeView(viewModel: viewModel)
}



