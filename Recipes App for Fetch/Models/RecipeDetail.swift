//
//  RecipeDetail.swift
//  Recipes App for Fetch
//
//  Created by Yunao Guo on 11/2/23.
//

import Foundation

struct RecipeDetail: Decodable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
    let strInstructions: String
    var ingredients: [String]
    var measurements: [String]
    let strYoutube: String?
    let strSource: String?
    let strCategory: String?
    let strArea: String?
    
    enum CodingKeys: String, CodingKey {
        case idMeal
        case strMeal
        case strMealThumb
        case strInstructions
        case strYoutube
        case strSource
        case strCategory
        case strArea
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5,
             strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10,
             strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15,
             strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20,
             strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5, strMeasure6,
             strMeasure7, strMeasure8, strMeasure9, strMeasure10, strMeasure11, strMeasure12,
             strMeasure13, strMeasure14, strMeasure15, strMeasure16, strMeasure17, strMeasure18,
             strMeasure19, strMeasure20
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        idMeal = try container.decode(String.self, forKey: .idMeal)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strMealThumb = try container.decode(String.self, forKey: .strMealThumb)
        strInstructions = try container.decode(String.self, forKey: .strInstructions)
        strYoutube = try container.decodeIfPresent(String.self, forKey: .strYoutube)
        strSource = try container.decodeIfPresent(String.self, forKey: .strSource)
        strCategory = try container.decodeIfPresent(String.self, forKey: .strCategory)
        strArea = try container.decodeIfPresent(String.self, forKey: .strArea)
        
        ingredients = (1...20).compactMap { try? container.decode(String.self, forKey: CodingKeys(stringValue: "strIngredient\($0)")! ) }
        measurements = (1...20).compactMap { try? container.decode(String.self, forKey: CodingKeys(stringValue: "strMeasure\($0)")! ) }
        
        // Remove the nil or empty entry
        ingredients = ingredients.filter { !$0.isEmpty }
        measurements = measurements.filter { !$0.isEmpty }
    }
}

struct RecipeResponse: Decodable {
    let meals: [RecipeDetail]
}
