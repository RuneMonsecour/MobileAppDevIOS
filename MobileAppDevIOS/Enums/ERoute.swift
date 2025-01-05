//
//  ERoute.swift
//  MobileAppDevIOS
//
//  Created by Rune Monsecour on 27/10/2024.
//

import Foundation

enum ERoute: String, CaseIterable {
	case dashboard = "Dashboard"
	case recipes = "Recepten"
	case calendar = "Kalender"
	
	func getIndex() -> Int {
		return ERoute.allCases.firstIndex(where: {route in route == self})!
	}
}

