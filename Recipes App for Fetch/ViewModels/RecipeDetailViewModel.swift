//
//  RecipeDetailViewModel.swift
//  Recipes App for Fetch
//
//  Created by Yunao Guo on 11/2/23.
//

import Foundation

import Combine

class RecipeDetailViewModel: ObservableObject {
    @Published var recipe: RecipeDetail?
    private let recipeID: String
    
    private var cancellables = Set<AnyCancellable>()
    
    init(recipeID: String) {
        self.recipeID = recipeID
    }
    
    func loadRecipeDetails() {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(recipeID)") else {
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: RecipeResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
            }, receiveValue: { recipeDetail in
                print(recipeDetail.meals)
                self.recipe = recipeDetail.meals.first
            })
            .store(in: &cancellables)
    }
}
