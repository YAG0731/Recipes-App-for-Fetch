//
//  HomeViewUITests.swift
//  Recipes App for FetchUITests
//
//  Created by Yunao Guo on 11/3/23.
//

import XCTest

final class HomeViewUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        app.launch()
    }
    
    func testSearchBar() {
        // Tap the search bar
        let searchBar = app.textFields["Search for dessert recipes"]
        XCTAssertTrue(searchBar.exists, "Search bar doesn't exist")
        searchBar.tap()
        
        // Type text into the search bar
        searchBar.typeText("Apam balik")  // Use the provided recipe name
        
        // Check if the recipes count label is updated
        let recipesCountLabel = app.staticTexts["recipes found"]
        XCTAssertTrue(recipesCountLabel.exists, "Recipes count label doesn't exist")
        XCTAssertEqual(recipesCountLabel.label, "1 recipe found")  // Check for 1 recipe
    }
    
    func testRecipeRow() {
        // Tap on a recipe row to navigate to the RecipeDetailView
        let recipeRow = app.buttons["Apam balik"]
        XCTAssertTrue(recipeRow.exists, "Recipe row doesn't exist")
        recipeRow.tap()
        
        // Create an expectation for the Recipe Detail View to appear
        let recipeDetailExpectation = expectation(description: "Recipe Detail View appears")
        
        // Check if you've navigated to the RecipeDetailView
        let exists = NSPredicate(format: "exists == 1")
        let recipeDetailQuery = app.otherElements["Recipe Detail View"]
        
        expectation(for: exists, evaluatedWith: recipeDetailQuery, handler: nil)
        
        // Wait for a specific time for the expectation to be fulfilled
        waitForExpectations(timeout: 10, handler: nil)
    }

    
    override func tearDown() {
        super.tearDown()
    }
}
