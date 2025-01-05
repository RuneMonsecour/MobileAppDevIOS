//
//  CalendarSlotView.swift
//  MobileAppDevIOS
//
//  Created by Rune Monsecour on 27/10/2024.
//

import SwiftUI

struct CalendarSlotView: View {
	let date: Date
	let dayRecipes: [EMealTime: [Recipe]]?
	var isDisabled = false
	
	var body: some View {
			VStack(alignment: .center){
				ScrollView() {
				
				Text("\(date.day)").padding(3)
					.foregroundStyle(Date().equals(date) ? .white : isDisabled ? .secondaryText : .primaryText)
					.background(
						Date()
							.equals(date) ? Circle()
							.fill(.accent).frame(width: 30)
						: Circle()
							.fill(.clear).frame()
					).frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
				
				let plannedRecipeCount = dayRecipes?.values.flatMap({$0}).count ?? 0
				if(plannedRecipeCount > 0) {
					CalendarPlannedRecipeView(
						plannedRecipeCount: plannedRecipeCount
					)
				}
				
				}.scrollDisabled(true).frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top).border(
				.gray,
				width: 0.5
			)
		}
	}
}

#Preview {
	CalendarSlotView(date: Date(), dayRecipes: nil)
}
