//
//  Recipe.swift
//  MobileAppDevIOS
//
//  Created by Rune Monsecour on 26/10/2024.
//

import Foundation

struct Recipe : Identifiable, Hashable, Codable {
	let id: Int
	let title: String
	
	struct ComplexSearch : Decodable {
		let results: [Recipe]
		let offset: Int
		let number: Int
		let totalResults: Int
	}
	
	struct Information : Decodable {
		let id: Int
		let title: String
		let summary: String
		let instructions: String
		let extendedIngredients: [Ingredient]
	}
}

