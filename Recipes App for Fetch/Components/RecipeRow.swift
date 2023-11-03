//
//  RecipeRow.swift
//  Recipes App for Fetch
//
//  Created by Yunao Guo on 11/1/23.
//

import SwiftUI

struct RecipeRow: View {
    var recipe: Recipe
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: recipe.strMealThumb)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .overlay(alignment: .bottom){
                            Text(recipe.strMeal)
                                .frame(maxWidth: 130)
                                .font(.system(size: 15, weight: .bold, design: .serif))
                                .foregroundStyle(.white)
                                .fontDesign(.serif)
                                .shadow(color: .black, radius: 15)
                                .padding([.bottom,.leading,.trailing],15)
                                
                        }

                } else if phase.error != nil {
                    // Handle the error or display a placeholder image
                    Image("Fetch_PrimaryLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)

                } else {
                    // Display an activity indicator while loading
                    ProgressView()
                }
            }
            .frame(width:160, height: 220, alignment: .top)
            .background(LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3),Color(.gray)]), startPoint: .top, endPoint: .bottomTrailing))
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: .gray, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            
            
        }
    }
}

#Preview {
    let sampleMeal = Recipe(idMeal: "12345", strMeal: "Alladin Sample Recipe", strMealThumb: "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg")
    
    return RecipeRow(recipe: sampleMeal)
        .previewLayout(.fixed(width: 300, height: 200))
}
