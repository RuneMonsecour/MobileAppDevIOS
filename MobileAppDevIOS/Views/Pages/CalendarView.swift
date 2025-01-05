//
//  Calendar.swift
//  MobileAppDevIOS
//
//  Created by Rune Monsecour on 26/10/2024.
//

import SwiftUI

struct CalendarView: View {
	@EnvironmentObject var viewModelFactory: ViewModelFactory
	@ObservedObject	var viewModel: CalendarViewModel
	
	var slotDestinationOverride: ((_ calendarDay: CalendarDay) -> AnyView)?
	@State private var position: Int? = 0
	
	func getSlotDestination(calendarDay: CalendarDay) -> AnyView {
		return slotDestinationOverride != nil ? slotDestinationOverride!(calendarDay) : AnyView(CalendarDayDetailsView(
			viewModel: viewModelFactory.makeCalendarDayDetailsViewModel(calendarDay: calendarDay)))
	}
	
	func handleOnEndScroll() {
		if(position == nil || position == 0) {
			return;
		}
		if(position! > 0) {
			viewModel.nextMonth()
		} else {
			viewModel.previousMonth()
		}
		position = 0
	}
	
	func handleOnScroll() {
		viewModel.refreshCalendarMonths()
	}
	
	var body: some View {
		NavigationStack {
			VStack(spacing: 0) {
				VStack {
					HStack{
						ForEach(viewModel.dayNames, id: \.self) { name in
							Text("\(name)").foregroundStyle(.primaryText)
						}.frame(maxWidth: .infinity)
					}.padding(.vertical, 1)
					DividerView()
				}
				
				GeometryReader { geometry in
					let rowHeight = geometry.size.height / 6;
					let rowWidth = geometry.size.width / 7;
					
					if #available(macOS 15.0, *) {
						scrollView(rowWidth: rowWidth, rowHeight: rowHeight).onScrollPhaseChange(
							{
								oldPhase,
								newPhase in
								if(
									oldPhase != ScrollPhase.idle && newPhase == ScrollPhase.idle
								) {
									handleOnEndScroll()
								} else if(
									oldPhase == ScrollPhase.idle && newPhase != ScrollPhase.idle
								) {
									handleOnScroll()
								}
							}
						)
					} else {
						scrollView(rowWidth: rowWidth, rowHeight: rowHeight).simultaneousGesture(
							DragGesture()
								.onEnded({_ in handleOnEndScroll()}).onChanged({_ in handleOnScroll()})
						)
					}
				}
			}.navigationTitle("\(viewModel.currentDate.toString(format: "MMMM yyyy"))").background(.whiteLightest)
		}
	}
	
	func scrollView(rowWidth: CGFloat, rowHeight: CGFloat) -> some View {
		ScrollView(showsIndicators: false) {
			LazyVStack(spacing: 0) {
				ForEach(
					viewModel.calendarMonths,
					id: \.self
				) { month in
					CalendarMonthView(
						viewModel: viewModelFactory
							.makeCalendarMonthViewModel(month: month),
						slotDestination: getSlotDestination,
						rowWidth: rowWidth,
						rowHeight: rowHeight
					).id(month.compareYearAndMonth(viewModel.currentDate))
				}
			}
		}.scrollTargetBehavior(.paging).scrollTargetLayout().defaultScrollAnchor(.center).scrollPosition(
			id: $position
		)
	}
}



#Preview {
	PreviewView(route: .calendar)
}




