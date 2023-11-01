//
//  HomeView.swift
//  RecipesApp-Fetch
//
//  Created by Yunao Guo on 10/31/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State private var currentPage: Int = 0
    
    var body: some View {
            TabView(selection: $currentPage) {
                ForEach(0..<viewModel.recipes.chunked(into: 8).count, id: \.self) { pageIndex in
                    ScrollViewReader { proxy in
                        ScrollView {
                            LazyVGrid(columns: [GridItem(.flexible())], spacing: 16) {
                                ForEach(viewModel.recipes.chunked(into: 8)[pageIndex], id: \.idMeal) { recipe in
                                    RecipeRow(recipe: recipe)
                                }
                            }
                            .onChange(of: pageIndex) { _ in
                                withAnimation {
                                    proxy.scrollTo(pageIndex)
                                }
                            }
                            .onAppear {
                                if pageIndex == viewModel.recipes.chunked(into: 8).count - 1 {
                                    viewModel.fetchRecipes()
                                }
                            }
                        }
                    }
                    .tag(pageIndex)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .onAppear {
                if viewModel.recipes.isEmpty {
                    viewModel.fetchRecipes()
                }
            }
            .navigationBarTitle("Dessert Recipes")
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}


