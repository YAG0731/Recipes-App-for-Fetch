//
//  RecipeDetailView.swift
//  Recipes App for Fetch
//
//  Created by Yunao Guo on 11/2/23.
//

import SwiftUI

struct RecipeDetailView: View {
    @ObservedObject var viewModel: RecipeDetailViewModel
    let recipeID: String
    
    init(recipeID: String) {
        self.viewModel = RecipeDetailViewModel()
        self.recipeID = recipeID
    }
    
    var body: some View {
        if let recipe = viewModel.recipe {
            VStack(spacing:-70){
                AsyncImage(url: URL(string: recipe.strMealThumb)) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 150)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                    case .failure:
                        Image("Fetch_PrimaryLogo")
                            .resizable()
                    case .empty:
                        ProgressView()
                    }
                }
                .ignoresSafeArea()
                
                ScrollView{
                    VStack {
                        // Display recipe details here
                        Text("\(recipe.strMeal)")
                            .fontWeight(.heavy)
                            .fontDesign(.serif)
                        
                        Text("Instructions:")
                            .font(.headline)
                            .position(x: 40)
                            .padding([.top, .leading], 10)
                        
                        Text("\(recipe.strInstructions)")
                            .fontDesign(.monospaced)
                            .font(.system(size: 13))
                        
                        Text("Ingredients:")
                            .font(.headline)
                            .position(x: 40)
                            .padding([.top, .leading], 10)
                        
                        // Loop through ingredients and measurements
                        ForEach(0..<min(recipe.ingredients.count, recipe.measurements.count), id: \.self) { index in
                            HStack {
                                Text("\(recipe.ingredients[index])")
                                    .fontDesign(.monospaced)
                                    .padding(4)
                                Spacer()
                                Text("\(recipe.measurements[index])")
                                    .fontDesign(.monospaced)
                                    .padding(4)
                            }
                            .background(.bar)
                            .border(.gray)
                            .opacity(0.8)
                        }
                    }
                    .padding()
                }
            }
            .accessibilityIdentifier("Recipe Detail View")
        } else {
            Text("Loading...")
                .onAppear {
                    Task {
                        viewModel.loadRecipeDetails(recipeID: recipeID)
                    }
                }
        }
    }
}

#Preview {
    RecipeDetailView(recipeID: "52893")
}
