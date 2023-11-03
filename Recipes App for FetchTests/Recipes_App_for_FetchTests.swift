//
//  Recipes_App_for_FetchTests.swift
//  Recipes App for FetchTests
//
//  Created by Yunao Guo on 10/31/23.
//

import XCTest
@testable import Recipes_App_for_Fetch

final class Recipes_App_for_FetchTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testGetAllRecipes() {
        let recipeService = RecipeService.shared
        let expectation = XCTestExpectation(description: "Fetch recipes")
        
        recipeService.getAllRecipes { result in
            switch result {
            case .success(let recipes):
                XCTAssertFalse(recipes.isEmpty, "Fetched recipes successfully")
            case .failure(let error):
                XCTFail("Failed to fetch recipes: \(error)")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10) // Adjust the timeout as needed
    }
    
    func testLoadAllRecipes() {
            let viewModel = HomeViewModel()
            let expectation = XCTestExpectation(description: "Load all recipes")

            viewModel.loadAllRecipes()

            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                XCTAssertTrue(!viewModel.recipes.isEmpty, "Recipes loaded successfully")
                expectation.fulfill()
            }

            wait(for: [expectation], timeout: 10) // Adjust the timeout as needed
        }

        func testToggleSortOrder() {
            let viewModel = HomeViewModel()
            viewModel.sortOption = .alphabetical
            viewModel.toggleSortOrder()
            XCTAssertEqual(viewModel.sortOption, .reverseAlphabetical, "Toggled sort order")

            viewModel.toggleSortOrder()
            XCTAssertEqual(viewModel.sortOption, .alphabetical, "Toggled sort order again")
        }

        func testFilteredRecipes() {
            let viewModel = HomeViewModel()
            viewModel.recipes = [
                Recipe(idMeal: "1", strMeal: "Pasta", strMealThumb: ""),
                Recipe(idMeal: "2", strMeal: "Pizza", strMealThumb: ""),
                Recipe(idMeal: "3", strMeal: "Burger", strMealThumb: ""),
            ]

            let filteredRecipes = viewModel.filteredRecipes(searchText: "P")
            XCTAssertEqual(filteredRecipes.count, 2, "Filtered recipes count")

            let filteredRecipesEmpty = viewModel.filteredRecipes(searchText: "X")
            XCTAssertEqual(filteredRecipesEmpty.count, 0, "Filtered recipes count (empty)")
        }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
