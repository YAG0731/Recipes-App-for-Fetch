//
//  Recipe.swift
//  RecipesApp-Fetch
//
//  Created by Yunao Guo on 10/31/23.
//

import Foundation

struct Recipe {
    let id: String
    let name: String
    let instructions: String?
    let ingredients: [(name: String, measurement: String)]
}
