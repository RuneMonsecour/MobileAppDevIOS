//
//  RecipeService.swift
//  MobileAppDevIOS
//
//  Created by Rune Monsecour on 27/10/2024.
//

import Foundation

class RecipeService {
	func getRecipes(query: String = "") async -> Result<Recipe.ComplexSearch> {
		var params = ""
		if(!query.isEmpty) {
			params = "?query=" + query
			print(params)
		}else{
			return Result.failure(456, "aaaah")
		}
		return await HttpClient.spoonacular.get(
			endpoint: "recipes/complexSearch" + params
		)
	}
	
	func getFavoriteRecipes(query: String = "") -> Result<Recipe.ComplexSearch> {
		let favorates = getFavorites()
		return Result
			.success(
				200,
				Recipe
					.ComplexSearch(
						results: favorates,
						offset: 0,
						number: 5,
						totalResults: favorates.count
					)
			)
	}
	
	func getRecipe(id: Int) async -> Result<Recipe.Information> {
		return await HttpClient.spoonacular.get(
			endpoint: "recipes/" + String(id) + "/information"
		)
	}
	
	private func getFavorites() -> [Recipe] {
		return LocalStorage.get(forKey: "favoriteRecipes") ?? []
	}
	
	private func setFavorites(recipes: [Recipe]) {
		LocalStorage.set(data: recipes, forKey: "favoriteRecipes")
	}
	
	func isRecipeFavorated(recipeId: Int) -> Bool {
		return getFavorites().contains(where: {recipe in recipe.id == recipeId})
	}
	
	func addFavoriteRecipe(recipe: Recipe) {
		var favorates = getFavorites()
		favorates.append(recipe)
		setFavorites(recipes: favorates)
	}
	
	func removeFavoriteRecipe(recipeId: Int) {
		print(recipeId)
		var favorates = getFavorites()
		print(favorates)
		favorates.removeAll(where: {recipe in recipe.id == recipeId})
		print(favorates)
		setFavorites(recipes: favorates)
	}
}



