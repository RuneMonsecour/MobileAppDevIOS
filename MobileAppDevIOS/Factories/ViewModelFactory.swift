//
//  ViewModelFactory.swift
//  MobileAppDevIOS
//
//  Created by Rune Monsecour on 28/10/2024.
//

import Foundation

class ViewModelFactory: ObservableObject {
	func makeCalendarDayDetailsViewModel(calendarDay: CalendarDay) -> CalendarDayDetailsViewModel {
		return CalendarDayDetailsViewModel(
			calendarDayService: CalendarDayService(),
			calendarDay: calendarDay
		)
	}
	
	func makeCalendarViewModel() -> CalendarViewModel {
		return CalendarViewModel(calendarDayService: CalendarDayService())
	}
	
	func makeCalendarMonthViewModel(month: Date) -> CalendarMonthViewModel {
		return CalendarMonthViewModel(calendarDayService: CalendarDayService(), month: month)
	}
	
	func makeRecipeListViewModel() -> RecipeListViewModel {
		return RecipeListViewModel(recipeService: RecipeService())
	}
	
	func makeRecipeDetailsViewModel(recipe: Recipe) -> RecipeDetailsViewModel {
		return RecipeDetailsViewModel(recipeService: RecipeService(), recipe: recipe)
	}
	
	func makeCalendarAddViewModel(recipe: Recipe, date: Date) -> CalendarAddViewModel {
		return CalendarAddViewModel(calendarDayService: CalendarDayService(), recipe: recipe, date: date)
	}
}
