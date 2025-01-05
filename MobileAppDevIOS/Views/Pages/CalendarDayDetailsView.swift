//
//  CalendarDayView.swift
//  MobileAppDevIOS
//
//  Created by Rune Monsecour on 27/10/2024.
//

import SwiftUI

struct CalendarDayDetailsView: View {
	@EnvironmentObject var viewModelFactory: ViewModelFactory
	@ObservedObject	var viewModel: CalendarDayDetailsViewModel
	
	func getSlotDestination(recipe: Recipe) -> AnyView {
		return AnyView(
			CalendarAddView(
				viewModel: viewModelFactory.makeCalendarAddViewModel(
					recipe: recipe,
					date: viewModel.calendarDay.date
				)
			)
		)
	}
	
	var body: some View {
		NavigationStack {
			VStack{
				ScrollView {
					ForEach(EMealTime.allCases, id: \.self) { mealTime in
						VStack {
							Text(mealTime.rawValue)
								.font(Font.title)
								.frame(maxWidth: .infinity, alignment: .leading)
							
							VStack(spacing: 5) {
								ForEach(
									viewModel.calendarDay.dayRecipes[mealTime] ?? [],
									id: \.self
								) { recipe in
									RecipeEntryView(recipe: recipe)
								}
							}.padding(2).frame(maxWidth: .infinity, alignment: .leading)
						}.padding(20).frame(maxWidth: .infinity, alignment: .leading)
					}
				}.frame(
					maxWidth: .infinity,
					maxHeight: .infinity,
					alignment: .top
				)
				
				NavigationLink(
					destination: RecipeListView(
						viewModel: viewModelFactory.makeRecipeListViewModel(),
						slotDestinationOverride: getSlotDestination
					)
				) {
					ButtonView(text: "Voeg recept toe")
				}
			}.frame(maxWidth: .infinity, maxHeight: .infinity).background(.whiteLightest)
				.navigationTitle("\(viewModel.calendarDay.date.toString(format: "EEEE d"))")
		}
	}
}

#Preview {
	CalendarDayDetailsView(
		viewModel: ViewModelFactory().makeCalendarDayDetailsViewModel(calendarDay: CalendarDay(date: Date()))
	).environmentObject(ViewModelFactory())
}

