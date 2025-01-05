//
//  CalendarDayViewModel.swift
//  MobileAppDevIOS
//
//  Created by Rune Monsecour on 27/10/2024.
//

import Foundation

class CalendarMonthViewModel: ObservableObject {
	private let calendarDayService: CalendarDayService
	
	@Published private(set) var calendarDays: [CalendarDay] = []
	@Published private(set) var calendarDates: [Date] = []
	
	@Published private(set) var month: Date
	
	init(calendarDayService: CalendarDayService, month: Date) {
		self.calendarDayService = calendarDayService
		self.month = month
		
		calendarDates = getCalendarDates(month: month)
		retrieveCalendarDays(month: month)
	}
	
	func retrieveCalendarDays(month: Date) {
		
		calendarDays = calendarDayService.getCalendarDays(date: month)
	}
	
	func getCalendarDates(month: Date) -> [Date] {
		var dates: [Date] = []
		var slotDate = Date.from(year: month.year, month: month.month, day: -Date.from(year: month.year, month: month.month).getDayOfWeek()+1)

		for _ in (1...6) {
			for _ in (1...7) {
				dates.append(slotDate);
				slotDate = slotDate.addDays(days: 1)
			}
		}
		
		return dates
	}
}

