//
//  RecipeDetailsViewModel.swift
//  MobileAppDevIOS
//
//  Created by Rune Monsecour on 28/10/2024.
//

import Foundation

class RecipeDetailsViewModel: ObservableObject {
	private let recipeService: RecipeService
	
	@Published private(set) var recipe: Recipe.Information? = nil
	@Published private(set) var isLoading = false
	@Published private(set) var error: String? = nil
	
	init(recipeService: RecipeService, recipe: Recipe) {
		self.recipeService = recipeService
		
		Task {
			await retrieveRecipe(id: recipe.id)
		}
	}
	
	@MainActor
	func retrieveRecipe(id: Int) async {
		isLoading = true;
		self.error = nil
		
		let result = await recipeService.getRecipe(id: id)
		if(result.isSuccess()) {
			recipe = result.getData()
		} else {
			recipe = Recipe
				.Information(
					id: 9,
					title: "pizza",
					image: "",
					summary: "yqsrgfguyirysdrygyrgyfd ggdfsg idfs hdfsyidsfyh dsfydydf  dsfgiuhdssdfuyi ufhf ou",
					instructions: "672tv8 g386574g8g635 6785y654 745368g 45678 543845385434545 6545",
					extendedIngredients: [Ingredient(id: 4, nameClean: "spruiten", image: "", measures: Ingredient.Measures(metric: Ingredient.Measure(amount: 45, unitShort: "g")))]
				)
//			self.error = result.error;
		}
		
		isLoading = false;
	}
	
}



