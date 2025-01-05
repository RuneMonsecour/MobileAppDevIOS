//
//  CalendarService.swift
//  MobileAppDevIOS
//
//  Created by Rune Monsecour on 27/10/2024.
//

import Foundation

class CalendarDayService {
	func getCalendarDays(date: Date) -> [CalendarDay] {
		var dates: [CalendarDay] = []
		var slotDate = Date.from(year: date.year, month: date.month)
		repeat {
			var calendarDay = CalendarDay(date: slotDate)
			calendarDay.dayRecipes = getPlannedRecipes(date: slotDate)
			dates.append(calendarDay);
			slotDate = slotDate.addDays(days: 1)
		} 
		while(slotDate.month == date.month)
		return dates
	}
	
	func getCalendarDay(date: Date) -> CalendarDay {
		var calendarDay = CalendarDay(date: date)
		calendarDay.dayRecipes = getPlannedRecipes(date: date)
		return calendarDay
	}
	
	private func getPlannedRecipes(date: Date) -> [EMealTime: [Recipe]] {
		if let dayRecipesData = UserDefaults.standard.data(
			forKey: date.toString(format: "dd-MM-yy")
		) {
			if let dayRecipesDecoded = try? JSONDecoder().decode([EMealTime: [Recipe]].self, from: dayRecipesData) {
				return dayRecipesDecoded
			}
		}
		return [:]
	}
	
	private func setPlannedRecipes(date: Date, dayRecipes: [EMealTime: [Recipe]]) {
		UserDefaults.standard.set(try? JSONEncoder().encode(dayRecipes), forKey: date.toString(format: "dd-MM-yy"))
	}
	
	func addPlannedRecipe(recipe: Recipe, mealTime: EMealTime, date: Date) {
		var dayRecipes = getPlannedRecipes(date: date)
		
		dayRecipes[mealTime, default: []].append(recipe)
		
		setPlannedRecipes(date: date, dayRecipes: dayRecipes)
	}
	
	func removePlannedRecipe(recipeId: Int, mealTime: EMealTime, date: Date) {
		var dayRecipes = getPlannedRecipes(date: date)
		
		dayRecipes[mealTime]?.removeAll(where: {recipe in recipe.id == recipeId})
		
		setPlannedRecipes(date: date, dayRecipes: dayRecipes)
	}
}
