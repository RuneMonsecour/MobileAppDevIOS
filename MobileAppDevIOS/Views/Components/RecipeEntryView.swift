//
//  RecipeEntry.swift
//  MobileAppDevIOS
//
//  Created by Rune Monsecour on 05/01/2025.
//

import SwiftUI

struct RecipeEntryView: View {
	let recipe: Recipe
	
    var body: some View {
			HStack {
				Text(recipe.title)
				Image(recipe.image)
			}.padding().frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading).border(
				.gray,
				width: 0.5
			)
    }
}

#Preview {
	RecipeEntryView(recipe: Recipe(id: 2, title: "Pizza", image: ""))
}
