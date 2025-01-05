//
//  RecipeDetailsViewModel.swift
//  MobileAppDevIOS
//
//  Created by Rune Monsecour on 28/10/2024.
//

import Foundation

class RecipeDetailsViewModel: ObservableObject {
	private let recipeService: RecipeService
	
	@Published private(set) var recipe: Recipe.Information
	@Published private(set) var isLoading = false
	@Published private(set) var error: String? = nil
	
	init(recipeService: RecipeService, recipe: Recipe) {
		self.recipeService = recipeService
		self.recipe = Recipe
			.Information(id: recipe.id, title: recipe.title, image: recipe.image)
		
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
			self.error = error;
		}
		
		isLoading = false;
	}
	
}



