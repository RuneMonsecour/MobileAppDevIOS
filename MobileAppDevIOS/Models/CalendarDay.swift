//
//  CalendarDay.swift
//  MobileAppDevIOS
//
//  Created by Rune Monsecour on 27/10/2024.
//

import Foundation

struct CalendarDay: Hashable {
	let date: Date
	var dayRecipes: [EMealTime: [Recipe]] = [:]
}
