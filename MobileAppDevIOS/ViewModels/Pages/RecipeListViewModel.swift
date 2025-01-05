//
//  RecipeViewModel.swift
//  MobileAppDevIOS
//
//  Created by Rune Monsecour on 27/10/2024.
//

import Foundation

class RecipeListViewModel: ObservableObject {
	private let recipeService: RecipeService
	
	@Published private(set) var recipes = Recipe.ComplexSearch(
		results: [],
		offset: 0,
		number: 0,
		totalResults: 0
	)
	@Published private(set) var isLoading = false
	@Published private(set) var error: String? = nil
	
	@Published var currentQuery = ""
	@Published private(set) var showFavorites = false
	
	init(recipeService: RecipeService) {
		self.recipeService = recipeService
		
		Task {
			await retrieveRecipes();
		}
	}
	
	func toggleShowFavorites() async {
		showFavorites.toggle()
		
		recipes = Recipe.ComplexSearch(
			results: [],
			offset: 0,
			number: 0,
			totalResults: 0
		)
		
		await	retrieveRecipes()
	}
	
	@MainActor
	func retrieveRecipes() async {
		isLoading = true;
		self.error = nil
		
		let result: Result<Recipe.ComplexSearch>
		if (showFavorites) {
			result = recipeService.getFavoriteRecipes(query: currentQuery)
		} else {
			result = await recipeService.getRecipes(query: currentQuery)
		}
		if(result.isSuccess()) {
			recipes = result.getData()
		} else {
			self.error = result.error;
		}
		
		isLoading = false;
	}
}



