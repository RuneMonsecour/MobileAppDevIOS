//
//  RecipeAddView.swift
//  MobileAppDevIOS
//
//  Created by Rune Monsecour on 28/10/2024.
//

import SwiftUI

struct CalendarAddView: View {
	@EnvironmentObject var router: Router
	@ObservedObject	var viewModel: CalendarAddViewModel
	
	func handleClickSave() {
		viewModel.save()
		router.navigate(route: .calendar)
	}
	
    var body: some View {
			VStack {
				LabeledValueView(label: "Recept", value: "\(viewModel.recipe.title)")
				DividerView()
				
				LabeledValueView(label: "Datum", value: "\(viewModel.date.toString(format: "dd MMMM yyyy"))")
				DividerView()
				
				HStack {
					Text("Tijdstip")
						.foregroundStyle(.secondaryText)
						.frame(maxWidth: 100, alignment: .leading)
					Menu {
						ForEach(EMealTime.allCases, id: \.self) {mealTime in
							Button(action: {
								viewModel.mealTime = mealTime
							}) {
								Text("\(mealTime.rawValue)")
							}
						}
					} label: {
						HStack {
							Text("\(viewModel.mealTime.rawValue)")
								.frame(maxWidth: .infinity,alignment: .leading)
							Image(.arrowDownKeyboard).imageScale(.large)
						}
							.foregroundStyle(.primaryText)
							.padding(.vertical, 10)
							.padding(.horizontal, 20)
							.background(RoundedRectangle(cornerRadius: 20).fill(.whiteLight))
					}
						.foregroundStyle(.primaryText)
						.frame(maxWidth: .infinity, alignment: .leading)
				}.padding()
				
				ButtonView(text: "Recept opslaan", action: {handleClickSave()})
					.frame(maxHeight: .infinity, alignment: .bottom)
			}.frame(
				maxHeight: .infinity, alignment: .top
			).navigationTitle("Voeg recept toe").background(.whiteLightest)
    }
}

#Preview {
	CalendarAddView(
		viewModel: ViewModelFactory()
			.makeCalendarAddViewModel(
				recipe: Recipe(id: 2, title: "Pizza", image: ""),
				date: Date()
			)
		)
	}
