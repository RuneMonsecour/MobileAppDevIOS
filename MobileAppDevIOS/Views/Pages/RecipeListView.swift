//
//  Recipes.swift
//  MobileAppDevIOS
//
//  Created by Rune Monsecour on 26/10/2024.
//

import SwiftUI

struct RecipeListView: View {
	@EnvironmentObject var viewModelFactory: ViewModelFactory
	@ObservedObject	var viewModel: RecipeListViewModel
	
	var slotDestinationOverride: ((_ recipe: Recipe) -> AnyView)?
	
	func getSlotDestination(recipe: Recipe) -> AnyView {
		return slotDestinationOverride != nil ? slotDestinationOverride!(recipe) : AnyView(RecipeDetailsView(
			viewModel: viewModelFactory
				.makeRecipeDetailsViewModel(recipe: recipe)
		)
		)
	}
	
	func handleClickFavorite() {
		Task {
			await viewModel.toggleShowFavorites()
		}
	}
	
	func handleSubmitSearch() {
		Task {
			await viewModel.retrieveRecipes()
		}
	}
	
	var body: some View {
		NavigationStack {
			VStack {
				HStack(spacing: 20) {
					HStack {
						Button(action: {handleSubmitSearch()}) {
							Image(.searchIcon).padding(
								.leading
							)
						}.foregroundStyle(.primaryText)
						TextField(
							"Zoeken",
							text: $viewModel.currentQuery
						)
						.padding(10)
						.onSubmit {
							handleSubmitSearch()
						}.frame(maxWidth: .infinity)
					}.background(RoundedRectangle(cornerRadius: 20).fill(.whiteLight))
					
					Button(action: {handleClickFavorite()}) {
						Image(
							viewModel.showFavorites ? .starFillIcon : .starIcon
						).imageScale(.large).foregroundStyle(
							viewModel.showFavorites ? .accent : .primaryText
						)
					}
				}.padding(.bottom, 10).padding(.horizontal, 20)
				
				VStack{
					AsyncDataView(
						isLoading: viewModel.isLoading,
						isLoadingMessage: "Recepten aan het laden...",
						error: viewModel.error
					) {
						ScrollView {
							LazyVGrid(columns: [GridItem(.adaptive(minimum: 170))]) {
								ForEach(viewModel.recipes.results) { recipe in
									NavigationLink(
										destination: getSlotDestination(recipe: recipe)
									) {
										RecipeSlotView(recipe: recipe)
									}.frame(maxWidth: .infinity)
								}
							}
							.padding(.all, 7)
						}
					}.frame(maxHeight: .infinity, alignment: .top)
				}
			}.background(.whiteLightest).navigationTitle(ERoute.recipes.rawValue)
		}
	}
}

#Preview {
	PreviewView(route: .recipes)
}







