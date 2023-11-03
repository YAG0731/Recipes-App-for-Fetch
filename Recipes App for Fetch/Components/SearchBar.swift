//
//  SearchBar.swift
//  Recipes App for Fetch
//
//  Created by Yunao Guo on 11/2/23.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var placeholder: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField(placeholder, text: $text)
                .foregroundColor(.primary)
                .fontDesign(.rounded)
        }
        .padding(8)
        .background(Color(.systemGray5))
        .cornerRadius(10)
    }
}

