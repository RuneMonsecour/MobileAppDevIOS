//
//  RecipeEntry.swift
//  MobileAppDevIOS
//
//  Created by Rune Monsecour on 05/01/2025.
//

import SwiftUI

struct RecipeEntryView: View {
	let recipe: Recipe
	var onRemove: ((_ recipeId: Int) -> Void)? = nil
	
    var body: some View {
			HStack {
				Text(recipe.title).foregroundStyle(.primaryText).frame(maxWidth: .infinity, alignment: .leading)
				if(onRemove != nil) {
					Button(action: {onRemove!(recipe.id)}) {
						Image(ImageResource.closeIcon).imageScale(.large)
					}
				}
			}.padding().frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading).background(
				RoundedRectangle(cornerRadius: 10)
					.stroke(Color.gray, lineWidth: 0.5)
			).padding(1)
    }
}

#Preview {
	RecipeEntryView(recipe: Recipe(id: 2, title: "Pizza", image: ""))
}
