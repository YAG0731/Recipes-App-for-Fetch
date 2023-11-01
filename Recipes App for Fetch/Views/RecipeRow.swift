//
//  RecipeRow.swift
//  Recipes App for Fetch
//
//  Created by Yunao Guo on 11/1/23.
//

import SwiftUI

struct RecipeRow: View {
    var recipe: Meal
    @State private var image: Image = Image("Fetch_PrimaryLogo")

    var body: some View {
        VStack {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 150)
                .cornerRadius(10)
                .onAppear {
                    // Load the image from the URL
                    if let url = URL(string: recipe.strMealThumb) {
                        URLSession.shared.dataTask(with: url) { data, response, error in
                            if let data = data, let uiImage = UIImage(data: data) {
                                image = Image(uiImage: uiImage)
                            }
                        }.resume()
                    }
                }
            
            Text(recipe.strMeal)
                .font(.headline)
        }
    }
}


struct RecipeRow_Previews: PreviewProvider {
    static var previews: some View {
        let sampleMeal = Meal(idMeal: "12345", strMeal: "Sample Recipe", strMealThumb: "https://www.themealdb.com//images//media//meals//xvsurr1511719182.jpg")
        
        return RecipeRow(recipe: sampleMeal)
            .previewLayout(.fixed(width: 300, height: 200)) // Adjust the size as needed
    }
}
