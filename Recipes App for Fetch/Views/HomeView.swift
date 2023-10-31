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
            List($viewModel.recipes, id: \.id) { recipe in
                NavigationLink(destination: DetailView(recipe: recipe)) {
                    Text(recipe.name)
                }
            }
            .onAppear {
                viewModel.fetchRecipes()
            }
        }
    }
}

#Preview {
    HomeView(viewModel: DetailViewModel)
}
