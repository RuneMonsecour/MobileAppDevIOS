//
//  DateUtil.swift
//  MobileAppDevIOS
//
//  Created by Rune Monsecour on 26/10/2024.
//

import Foundation

extension Date{
	
	var year: Int {
		return Calendar.current.component(.year, from: self)
	}
	
	var month: Int {
		return Calendar.current.component(.month, from: self)
	}
	
	var day: Int {
		return Calendar.current.component(.day, from: self)
	}
	
	static func from(year: Int, month: Int) -> Date {
		
		if(month > 12) {
			return Date.from(year: year + 1, month: month - 12)
		}
		if(month < 1) {
			return Date.from(year: year - 1, month: month + 12)
		}
		
		return Calendar.current
			.date(from: DateComponents(year: year, month: month))!
	}
	
	static func from(year: Int, month: Int, day: Int) -> Date {
		var date = Date.from(year: year, month: month)

		if (day < 1) {
			return Date
				.from(
					year: date.year,
					month: date.month - 1,
					day: day + getDaysInMonth(
						year: year,
						month: month - 1
					)
				)
		}
		let daysInCurrentMonth = getDaysInMonth(year: year, month: month)
		if (day > daysInCurrentMonth) {
			return Date.from(year: date.year, month: date.month + 1, day: day - daysInCurrentMonth)
		}
		
		date = Date.from(year: date.year, month: date.month)
		return Calendar.current.date(from: DateComponents(year: date.year, month: date.month, day: day))!
	}
	
	static func getDaysInMonth(year: Int, month: Int) -> Int {
		let daysInMonths = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
		let date = Date.from(year: year, month: month)
		
		if (date.month == 2 && date.year % 4 == 0) {
			return 29;
		}
		
		return daysInMonths[date.month - 1]
	}
	
	func addDays(days: Int) -> Date {
		return Date.from(year: self.year, month: self.month, day: self.day + days)
	}
	
	func addMonths(months: Int) -> Date {
		let targetMonth = Date.from(
			year: self.year,
			month: self.month + months
		)
		let daysInTargetMonth = Date.getDaysInMonth(
			year: targetMonth.year,
			month: targetMonth.month
		)
		return Date
			.from(year: targetMonth.year, month: targetMonth.month, day: min(daysInTargetMonth, self.day))
	}
	
	// EEEE (Tuesday), EEE (Tue), dd (27)
	// MMMM (October), MMM (Oct), MM (10)
	// yy (2024)
	func toString(format: String) -> String {
		let dateFormatter = DateFormatter();
		dateFormatter.dateFormat = format
		return dateFormatter.string(from: self);
	}
	
	func getDayOfWeek() -> Int {
		return (Calendar.current.component(.weekday, from: self) + 5) % 7;
	}
	
	func equals(_ other: Date, includeDay: Bool = true) -> Bool {
		return self.year == other.year && self.month == other.month && (
			!includeDay || self.day == other.day);
	}
	
	func compareYearAndMonth(_ other: Date) -> Int {
		return self.year != other.year ? self.year - other.year : self.month - other.month
	}
}



