//
//  Recipe.swift
//  MobileAppDevIOS
//
//  Created by Rune Monsecour on 26/10/2024.
//

import SwiftUI

struct RecipeDetailsView: View {
	@EnvironmentObject var viewModelFactory: ViewModelFactory
	@ObservedObject	var viewModel: RecipeDetailsViewModel
	
	func getCalendarDestination(calendarDay: CalendarDay) -> AnyView {
		return AnyView(
			CalendarAddView(
				viewModel: viewModelFactory
					.makeCalendarAddViewModel(
						recipe: Recipe(
							id: viewModel.recipe.id,
							title: viewModel.recipe.title,
							image: viewModel.recipe.image
						),
						date: calendarDay.date
					)
			)
		)
	}
	
	var body: some View {
		NavigationStack {
			VStack {
				VStack {}.frame(maxWidth: .infinity, maxHeight: .infinity)
				
				NavigationLink(
					destination: CalendarView(
						viewModel: viewModelFactory.makeCalendarViewModel(),
						slotDestinationOverride: getCalendarDestination
					)
				) {
					ButtonView(text: "Voeg toe aan kalender")
				}
				
			}.frame(maxWidth: .infinity, maxHeight: .infinity).background(.whiteLightest).navigationTitle(
				"\(viewModel.recipe.title)"
			)
		}
	}
}

#Preview {
	RecipeDetailsView(
		viewModel: ViewModelFactory()
			.makeRecipeDetailsViewModel(recipe: Recipe(id: 725469, title: "Pizza", image: ""))
	).environmentObject(ViewModelFactory())
}


