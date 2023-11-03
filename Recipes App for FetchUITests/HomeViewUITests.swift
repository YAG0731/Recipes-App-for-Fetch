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
        // Assuming the RecipeRow has a unique accessibility identifier.
        let recipeRow = app.buttons["Apam balik"]
        XCTAssertTrue(recipeRow.exists, "Recipe row doesn't exist")
        
        // Tap the RecipeRow to navigate to the Recipe Detail View.
        recipeRow.tap()
        
        // Assuming the Recipe Detail View also has an accessibility identifier.
    
    }

    
    override func tearDown() {
        super.tearDown()
    }
}
