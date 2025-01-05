//
//  Header.swift
//  MobileAppDevIOS
//
//  Created by Rune Monsecour on 26/10/2024.
//

import SwiftUI

struct NavMenuView: View {
	@EnvironmentObject var router: Router
	
	func handleClickNavItem(route: ERoute) {
		router.navigate(route: route)
	}
	
	func getRouteIcons(route: ERoute) -> (default: ImageResource, selected: ImageResource) {
		switch route {
		case .calendar: return (.calendarIcon, .calendarFillIcon)
		case .recipes: return (.menuBookIcon, .menuBookFillIcon)
		}
	}
	
	var body: some View {
		VStack {
			DividerView()
			HStack{
				ForEach(ERoute.allCases, id: \.self) { route in
					NavItemView(
						route: route,
						onClick: handleClickNavItem,
						isSelected: router.currentRoute == route,
						icons: getRouteIcons(route: route)
					)
				}
			}
		}
		.frame(maxWidth: .infinity)
		.background(.whiteLighter).padding(.bottom, 20)
		
	}
}

#Preview {
	PreviewView()
}

