//
//  Ingredient.swift
//  MobileAppDevIOS
//
//  Created by Rune Monsecour on 05/01/2025.
//

import Foundation

struct Ingredient : Decodable, Identifiable, Hashable {
	let id: Int
	let nameClean: String
	let image: String
	let measures: Measures
	
	struct Measures : Decodable, Hashable {
		let metric: Measure
	}
	
	struct Measure : Decodable, Hashable {
		let amount: Float
		let unitShort: String
	}
}

