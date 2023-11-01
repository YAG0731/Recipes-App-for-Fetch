//
//  Recipe.swift
//  RecipesApp-Fetch
//
//  Created by Yunao Guo on 10/31/23.
//

import Foundation

struct RecipeDetail: Decodable {
    let idMeal: String
    let strMeal: String
    let strCategory: String
    let strArea: String
    let strInstructions: String
    let strMealThumb: String
    var ingredients: [String] = []  // Store ingredients in an array
    var measurements: [String] = [] // Store measurements in an array
    let strYoutube: String
    let strSource: String

    // Custom coding keys to handle ingredients and measurements
    
}


