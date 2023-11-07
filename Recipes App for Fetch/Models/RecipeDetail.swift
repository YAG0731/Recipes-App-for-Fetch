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

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)

        idMeal = try container.decode(String.self, forKey: .string("idMeal"))
        strMeal = try container.decode(String.self, forKey: .string("strMeal"))
        strMealThumb = try container.decode(String.self, forKey: .string("strMealThumb"))
        strInstructions = try container.decode(String.self, forKey: .string("strInstructions"))
        strYoutube = try container.decodeIfPresent(String.self, forKey: .string("strYoutube"))
        strSource = try container.decodeIfPresent(String.self, forKey: .string("strSource"))
        strCategory = try container.decodeIfPresent(String.self, forKey: .string("strCategory"))
        strArea = try container.decodeIfPresent(String.self, forKey: .string("strArea"))

        // Decode ingredients and measurements
        ingredients = (1...20).compactMap { try? container.decode(String.self, forKey: .string("strIngredient\($0)")) }
        measurements = (1...20).compactMap { try? container.decode(String.self, forKey: .string("strMeasure\($0)")) }

        // Remove the nil or empty entries
        ingredients = ingredients.filter { !$0.isEmpty }
        measurements = measurements.filter { !$0.isEmpty }
    }

    struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        var intValue: Int?

        init?(stringValue: String) {
            self.stringValue = stringValue
            self.intValue = Int(stringValue)
        }

        init?(intValue: Int) {
            self.intValue = intValue
            self.stringValue = String(intValue)
        }

        static func string(_ string: String) -> DynamicCodingKeys {
            return DynamicCodingKeys(stringValue: string)!
        }
    }
}



struct RecipeResponse: Decodable {
    let meals: [RecipeDetail]
}
