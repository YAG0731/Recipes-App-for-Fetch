//
//  Meal.swift
//  Recipes App for Fetch
//
//  Created by Yunao Guo on 11/1/23.
//

import Foundation

struct Meal: Decodable, Equatable, Hashable {
    var idMeal: String
    var strMeal: String
    var strMealThumb: String
}
