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
				Recipe.ComplexSearch(results: [Recipe(id: 2, title: "Pizza", image: ""),Recipe(id: 24, title: "qweqwe", image: ""),Recipe(id: 22, title: "cvbcvb", image: ""),Recipe(id: 23, title: "sdfsdf", image: ""),Recipe(id: 255, title: "yukyuk", image: "")], offset: 0, number: 5, totalResults: 5)
			)
	}
	
	func getRecipe(id: Int) async -> Result<Recipe.Information> {
		return await HttpClient.spoonacular.get(
			endpoint: "recipes/" + String(id) + "/information"
		)
	}
}
