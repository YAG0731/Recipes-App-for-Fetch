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

    func fetchRecipes() {
        if let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    if let decodedResponse = try? JSONDecoder().decode(MealsResponse.self, from: data) {
                        DispatchQueue.main.async {
                            self.recipes = decodedResponse.meals
                        }
                        return
                    }
                }
                // Handle errors here, such as network or decoding errors
            }.resume()
        }
    }
}
