//
//  Recipes_App_for_FetchUITests.swift
//  Recipes App for FetchUITests
//
//  Created by Yunao Guo on 10/31/23.
//

import XCTest

final class Recipes_App_for_FetchUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        app.launch()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSearchBar() {
        let app = XCUIApplication()
        app.launch() // Launch the app before performing UI tests
        
        let searchBar = app.textFields["Search for dessert recipes"]
        XCTAssertTrue(searchBar.exists, "Search bar doesn't exist")
        searchBar.tap()
        
        let recipesCountLabel = app.staticTexts["recipes found"]
        XCTAssertTrue(recipesCountLabel.exists, "Recipes count label doesn't exist")
        
        // Type text into the search bar
        searchBar.typeText("Chocolate Avocado")
        
        let recipesCount = recipesCountLabel.label
        XCTAssertEqual(recipesCount, "1 recipe found", "Recipes count is not as expected")
    }
    
    func testRecipeRow() {
        // Assuming the RecipeRow has a unique accessibility identifier.
        let recipeRow = app.buttons["Apam balik"]
        XCTAssertTrue(recipeRow.exists, "Recipe row doesn't exist")
        
        recipeRow.tap()
    
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
