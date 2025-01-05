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
			await retrieveRecipes(offset: 0);
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
		
		await	retrieveRecipes(offset: 0)
	}
	
	@MainActor
	func retrieveRecipes(offset: Int) async {
		isLoading = true;
		self.error = nil
		
		let result: Result<Recipe.ComplexSearch>
		if (showFavorites) {
			result = recipeService.getFavoriteRecipes(offset: offset, query: currentQuery)
		} else {
			result = await recipeService.getRecipes(offset: offset, query: currentQuery)
		}
		if(result.isSuccess()) {
			recipes = result.getData()
		} else {
			self.error = result.error;
		}
		
		isLoading = false;
	}
}



