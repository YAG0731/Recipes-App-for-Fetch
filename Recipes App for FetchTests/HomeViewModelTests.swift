//
//  HomeViewModelTests.swift
//  Recipes App for FetchTests
//
//  Created by Yunao Guo on 11/3/23.
//

import XCTest
@testable import Recipes_App_for_Fetch // Update this import with your app's module name

final class HomeViewModelTests: XCTestCase {
    var viewModel: HomeViewModel!

    override func setUp() {
        super.setUp()
        viewModel = HomeViewModel()
    }

    override func tearDown() {
        viewModel = nil
        //super.teardown()
    }

    

    // Add more test cases as needed to cover other functions and scenarios
}

