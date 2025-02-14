//
//  CalendarPlannedRecipe.swift
//  MobileAppDevIOS
//
//  Created by Rune Monsecour on 05/01/2025.
//

import SwiftUI

struct CalendarPlannedRecipeView: View {
	let plannedRecipeCount: Int
	
	var body: some View {
		Text(String(plannedRecipeCount))
			.foregroundStyle(.white)
			.padding(10)
			.background(.primary).cornerRadius(5)
	}
}

