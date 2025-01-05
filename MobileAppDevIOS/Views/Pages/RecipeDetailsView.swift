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
							title: viewModel.recipe?.title ?? ""
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
				isLoadingMessage: "Loading recipe...",
				error: viewModel.error
			) {
				VStack {
					ScrollView{
						VStack(spacing: 40){
							Text(viewModel.recipe?.summary ?? "")
							
							VStack(spacing: 4) {
								Text("Instructions").font(Font.title2)
								Text(viewModel.recipe?.instructions ?? "")
							}
							
							VStack(spacing: 4) {
								Text("Ingredients").font(Font.title2)
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
						}
					}.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top).padding(10)
					
					NavigationLink(
						destination: CalendarView(
							viewModel: viewModelFactory.makeCalendarViewModel(),
							slotDestinationOverride: getCalendarDestination
						)
					) {
						ButtonView(text: "Add to calendar")
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
			.makeRecipeDetailsViewModel(recipe: Recipe(id: 725469, title: "Pizza"))
	).environmentObject(ViewModelFactory())
}


