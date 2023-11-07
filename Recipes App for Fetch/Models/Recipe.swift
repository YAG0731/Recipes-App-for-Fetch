//
//  Recipe.swift
//  Recipes App for Fetch
//
//  Created by Yunao Guo on 11/2/23.
//

import Foundation

struct Recipe: Decodable, Equatable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
}

extension Recipe {
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.idMeal == rhs.idMeal
    }
}

struct MealsResponse: Decodable {
    var meals: [Recipe]
}
