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
			params = "?query=\"" + query + "\""
		}
		return await HttpClient.spoonacular.get(
			endpoint: "recipes/complexSearch" + params
		)
	}
	
	func getFavoriteRecipes(query: String = "") -> Result<Recipe.ComplexSearch> {
		return Result
			.success(
				200,
				Recipe.ComplexSearch(results: [Recipe(id: 2, title: "Pizza", image: "")], offset: 0, number: 1, totalResults: 1)
			)
	}
	
	func getRecipe(id: Int) async -> Result<Recipe.Information> {
		return await HttpClient.spoonacular.get(
			endpoint: "recipes/" + String(id) + "/information"
		)
	}
}
