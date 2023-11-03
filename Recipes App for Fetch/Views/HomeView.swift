//
//  HomeView.swift
//  RecipesApp-Fetch
//
//  Created by Yunao Guo on 10/31/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State private var searchText = ""
    let columns: [GridItem] = [GridItem(.adaptive(minimum: 160), spacing: 15)]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HStack {
                    SearchBar(text: $searchText, placeholder: "Search for dessert recipes")
                    
                    Spacer()
                    
                    Image(viewModel.sortOption == .alphabetical ? "icons8-alphabetical-sorting-2-72(@3×)" : "icons8-sort-72(@3×)")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .onTapGesture {
                            viewModel.toggleSortOrder()
                        }
                }
                .padding([.leading, .trailing], 10)
                
                HStack {
                    Spacer()
                    
                    Text("\(viewModel.filteredRecipes(searchText: searchText).count) \(viewModel.filteredRecipes(searchText: searchText).count != 1 ? "recipes" : "recipe") found")
                        .font(.system(.caption2, design: .monospaced))
                        .padding(10)
                }
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(viewModel.filteredRecipes(searchText: searchText), id: \.idMeal) { recipe in
                            NavigationLink(destination: RecipeDetailView(recipeID: recipe.idMeal)) {
                                RecipeRow(recipe: recipe)
                            }
                        }
                    }
                    .padding([.leading, .trailing], 20)
                    .padding(.top, 10)
                }
                .onAppear {
                    viewModel.loadAllRecipes()
                }
            }
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



