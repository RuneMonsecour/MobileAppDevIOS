//
//  CalendarDayViewModel.swift
//  MobileAppDevIOS
//
//  Created by Rune Monsecour on 27/10/2024.
//

import Foundation

class CalendarViewModel: ObservableObject {
	private let calendarDayService: CalendarDayService
	
	let dayNames: [String]
	
	@Published private(set) var currentDate = Date()
	@Published private(set) var calendarMonths: [Date] = []
	
	init(calendarDayService: CalendarDayService) {
		self.calendarDayService = calendarDayService
		
		dayNames = CalendarViewModel.getDayNames()
		calendarMonths = [currentDate]
	}
	
	func refreshCalendarMonths() {
		if(calendarMonths.count < 3 || calendarMonths[1] != currentDate) {
			calendarMonths = [
				currentDate.addMonths(months: -1),
				currentDate,
				currentDate.addMonths(months: 1)
			]
		}
	}
	
	func nextMonth() {
		currentDate = currentDate.addMonths(months: 1)
		refreshCalendarMonths()
	}
	
	func previousMonth() {
		currentDate = currentDate.addMonths(months: -1)
		refreshCalendarMonths()
	}
	
	static func getDayNames() -> [String] {
		var names: [String] = []
		
		var now = Date()
		for _ in (1...7) {
			names
				.insert(
					now.toString(format: "EEE"),
					at: min(now.getDayOfWeek(), names.count)
				)
			now = now.addDays(days: 1)
		}
		
		return names;
	}
}

