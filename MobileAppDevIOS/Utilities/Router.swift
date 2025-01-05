//
//  Router.swift
//  MobileAppDevIOS
//
//  Created by Rune Monsecour on 27/10/2024.
//

import SwiftUI

class Router: ObservableObject {
	let viewModelFactory: ViewModelFactory
	var previousRoute: ERoute
	@Published var currentRoute: ERoute
	var pageId = 0
	
	init(viewModelFactory: ViewModelFactory, defaultRoute: ERoute) {
		self.viewModelFactory = viewModelFactory
		self.previousRoute = defaultRoute
		self.currentRoute = defaultRoute
	}
	
	@ViewBuilder func getView(route: ERoute) -> some View {
		switch route {
		case .calendar:
			AnyView(CalendarView(viewModel: viewModelFactory.makeCalendarViewModel()))
		case .recipes:
			AnyView(
				RecipeListView(viewModel: viewModelFactory.makeRecipeListViewModel())
			)
		case .dashboard:
			AnyView(
				DashboardView()
			)
		}
	}
	
	func navigate(route: ERoute) {
		pageId = pageId + 1
		self.previousRoute = currentRoute
			withAnimation {
				currentRoute = route
			}
	}
}

