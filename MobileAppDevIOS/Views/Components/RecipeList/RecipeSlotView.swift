//
//  RecipeSlotView.swift
//  MobileAppDevIOS
//
//  Created by Rune Monsecour on 27/10/2024.
//

import SwiftUI

struct RecipeSlotView: View {
	let recipe: Recipe
	
	var body: some View {
			Text("\(recipe.title)")
				.multilineTextAlignment(.center)
				.frame(maxWidth: .infinity)
				.foregroundStyle(.primaryText)
				.padding(4).background(
					RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 1)
				)
	}
}

#Preview {
	RecipeSlotView(recipe: Recipe(id: 2, title: "Pizza", image: ""))
}
