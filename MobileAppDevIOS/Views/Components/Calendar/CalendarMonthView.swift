//
//  CalendarMonthView.swift
//  MobileAppDevIOS
//
//  Created by Rune Monsecour on 29/10/2024.
//

import SwiftUI

struct CalendarMonthView: View {
	@ObservedObject	var viewModel: CalendarMonthViewModel
	
	let slotDestination: (_ calendarDay: CalendarDay) -> AnyView
	let rowWidth: CGFloat
	let rowHeight: CGFloat
	
	var body: some View {
		LazyVGrid(columns: Array(repeating: GridItem(), count: 7), spacing: 0) {
			ForEach(viewModel.calendarDates, id: \.self) { date in
				
				NavigationLink(
					destination: slotDestination(
						viewModel.calendarDays
							.first{$0.date.equals(date)} ?? CalendarDay(date: Date())
					)
				) {
					CalendarSlotView(
						date: date,
						dayRecipes: viewModel.calendarDays
							.first(
								where: {calendarDay in calendarDay.date.equals(date)}
							)?.dayRecipes,
						isDisabled: !viewModel.month
							.equals(date, includeDay: false)
					)
					
				}.frame(width: rowWidth, height: rowHeight).disabled(!viewModel.calendarDays.contains{$0.date.equals(date)})
				
			}
		}
	}
}



