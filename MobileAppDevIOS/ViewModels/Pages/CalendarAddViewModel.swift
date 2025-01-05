//
//  RecipeAddViewModel.swift
//  MobileAppDevIOS
//
//  Created by Rune Monsecour on 28/10/2024.
//

import Foundation

class CalendarAddViewModel: ObservableObject {
	private let calendarDayService: CalendarDayService
	
	let recipe: Recipe
	let date: Date
	@Published var mealTime: EMealTime = .Breakfast
	
	init(calendarDayService: CalendarDayService, recipe: Recipe, date: Date) {
		self.calendarDayService = calendarDayService
		self.recipe = recipe
		self.date = date
	}
	
	func save() {
		calendarDayService
			.addPlannedRecipe(recipe: recipe, mealTime: mealTime, date: date)
	}
}
