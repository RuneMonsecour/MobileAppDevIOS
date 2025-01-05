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
	
	@Published private(set) var isFavorited = false
	
	init(recipeService: RecipeService, recipe: Recipe) {
		self.recipeService = recipeService
		isFavorited = recipeService.isRecipeFavorated(recipeId: recipe.id)
		
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
			self.error = result.error;
		}
		
		isLoading = false;
	}
	
	func toggleFavorite() {
		if(recipe == nil) {
			return
		}
		
		if(isFavorited) {
			recipeService.removeFavoriteRecipe(recipeId: recipe!.id)
		} else {
			recipeService
				.addFavoriteRecipe(
					recipe: Recipe(
						id: recipe!.id,
						title: recipe!.title,
						image: recipe!.image
					)
				)
		}
		
		isFavorited = !isFavorited
	}
}



