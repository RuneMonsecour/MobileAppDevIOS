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
							id: viewModel.recipe?.id ?? -1,
							title: viewModel.recipe?.title ?? "",
							image: viewModel.recipe?.image ?? ""
						),
						date: calendarDay.date
					)
			)
		)
	}
	
	func handleClickFavorite() {
		viewModel.toggleFavorite()
	}

	var body: some View {
		NavigationStack {
			AsyncDataView(
				isLoading: viewModel.isLoading,
				isLoadingMessage: "Recept aan het laden...",
				error: viewModel.error
			) {
				VStack {
					VStack(spacing: 40) {
						Text(viewModel.recipe?.summary ?? "")
						
						VStack(spacing: 4) {
							Text("Instructies").font(Font.title2)
							Text(viewModel.recipe?.instructions ?? "")
						}
						
						VStack(spacing: 4) {
							Text("Ingredienten").font(Font.title2)
							VStack(spacing: 4) {
								ForEach(viewModel.recipe?.extendedIngredients ?? [], id: \.self) { ingredient in
									Text(
										String(
											ingredient.measures.metric.amount
										)+ingredient.measures.metric.unitShort + " " + ingredient.nameClean
									)
								}
							}
						}
					}.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
					
					NavigationLink(
						destination: CalendarView(
							viewModel: viewModelFactory.makeCalendarViewModel(),
							slotDestinationOverride: getCalendarDestination
						)
					) {
						ButtonView(text: "Voeg toe aan kalender")
							.disabled(viewModel.isLoading)
					}
					
				}.frame(maxWidth: .infinity, maxHeight: .infinity).background(.whiteLightest).navigationTitle(
					"\(viewModel.recipe?.title ?? "")"
				).toolbar {
					ToolbarItem() {
						FavoriteButtonView(
							action: handleClickFavorite,
							isFavorite: viewModel.isFavorited
						)
					}
				}
			}
		}
	}
}

#Preview {
	RecipeDetailsView(
		viewModel: ViewModelFactory()
			.makeRecipeDetailsViewModel(recipe: Recipe(id: 725469, title: "Pizza", image: ""))
	).environmentObject(ViewModelFactory())
}


