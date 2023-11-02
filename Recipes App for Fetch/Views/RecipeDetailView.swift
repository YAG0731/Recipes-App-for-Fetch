//
//  RecipeDetailView.swift
//  Recipes App for Fetch
//
//  Created by Yunao Guo on 11/2/23.
//

import SwiftUI

struct RecipeDetailView: View {
    @ObservedObject var viewModel: RecipeDetailViewModel
    @State private var image: Image = Image("Fetch_PrimaryLogo")
    
    init(recipeID: String) {
        self.viewModel = RecipeDetailViewModel(recipeID: recipeID)
    }
    
    var body: some View {
        if let recipe = viewModel.recipe {
            ScrollView {
                VStack {
                    // Display recipe details here
                    Text("\(recipe.strMeal)")
                        .fontWeight(.heavy)
                        .fontDesign(.serif)
                    
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)
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

                    
                    Text("Instructions:")
                        .font(.headline)
                        .position(x:40)
                        .padding([.top,.leading],10)
                    
                    Text("\(recipe.strInstructions)")
                        .fontDesign(.monospaced)
                        .font(.system(size: 13))
                        .padding(0)
                    
                    Text("Ingredients:")
                        .font(.headline)
                        .position(x:40)
                        .padding([.top,.leading],10)
                                            // Loop through ingredients and measurements
                    ForEach(0..<min(recipe.ingredients.count, recipe.measurements.count), id: \.self) { index in
                        HStack{
                            Text("\(recipe.ingredients[index])")
                                .fontDesign(.monospaced)
                                .padding(3)
                            Spacer()
                            Text("\(recipe.measurements[index])")
                                .fontDesign(.monospaced)
                                .padding(3)
                        }
                        .background(.bar)
                        .border(.gray)
                    }
                }
                .padding()
            }
        } else {
            Text("Loading...")
        }
    }
}

#Preview {
    RecipeDetailView(recipeID: "52893")
}
