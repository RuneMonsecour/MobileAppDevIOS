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
		
		retrieveCalendarDay(date: calendarDay.date)
	}
	
	func retrieveCalendarDay(date: Date) {
		self.calendarDay = calendarDayService.getCalendarDay(date: date)
	}
}
