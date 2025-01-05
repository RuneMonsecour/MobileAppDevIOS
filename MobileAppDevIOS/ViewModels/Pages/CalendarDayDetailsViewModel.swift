//
//  CalendarDayDetailsViewModel.swift
//  MobileAppDevIOS
//
//  Created by Rune Monsecour on 28/10/2024.
//

import Foundation

class CalendarDayDetailsViewModel: ObservableObject {
	private let calendarDayService: CalendarDayService
	
	@Published private(set) var calendarDay: CalendarDay
	
	init(calendarDayService: CalendarDayService, calendarDay: CalendarDay) {
		self.calendarDayService = calendarDayService
		self.calendarDay = calendarDay
	}
	
	func removeRecipe(recipeId: Int, mealTime: EMealTime) {
		calendarDayService
			.removePlannedRecipe(
				recipeId: recipeId,
				mealTime: mealTime,
				date: calendarDay.date
			)
		calendarDay
			.dayRecipes[mealTime]?
			.removeAll(where: {recipe in recipe.id == recipeId})
	}
}
