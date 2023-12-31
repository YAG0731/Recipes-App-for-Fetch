//
//  Recipes_App_for_FetchApp.swift
//  Recipes App for Fetch
//
//  Created by Yunao Guo on 10/31/23.
//

import SwiftUI

@main
struct Recipes_App_for_FetchApp: App {
    @StateObject private var homeViewModel = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: homeViewModel)
        }
    }
}
