//
//  HomeViewModels.swift
//  RecipesApp-Fetch
//
//  Created by Yunao Guo on 10/31/23.
//

import SwiftUI

struct MealsResponse: Decodable {
    let meals: [Meal]
}

class HomeViewModel: ObservableObject {
    @Published var recipes: [Meal] = []
    @Published var currentPage: Int = 1
    @Published var isLoading: Bool = false
    @Published var hasMorePages: Bool = true

    func fetchRecipes() {
        // If we are already loading or there are no more pages, return early.
        if isLoading || !hasMorePages {
            return
        }

        isLoading = true

        if let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert&p=\(currentPage)") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    self.isLoading = false
                }

                if let data = data {
                    if let decodedResponse = try? JSONDecoder().decode(MealsResponse.self, from: data) {
                        DispatchQueue.main.async {
                            if decodedResponse.meals.isEmpty {
                                self.hasMorePages = false
                            } else {
                                self.recipes += decodedResponse.meals
                                self.currentPage += 1
                            }
                        }
                        return
                    }
                }
                // Handle errors here, such as network or decoding errors
            }.resume()
        }
    }
    
    func loadMoreContentIfNeeded(currentItem: Meal?) {
        guard !isLoading && hasMorePages else { return }

        if let currentItem = currentItem, currentItem == recipes.last {
            fetchRecipes()
        }
    }
    
}
