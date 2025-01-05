//
//  LocalStorage.swift
//  MobileAppDevIOS
//
//  Created by Rune Monsecour on 05/01/2025.
//

import Foundation

class LocalStorage {
	static func get<T: Decodable>(forKey: String) -> T? {
		if let data = UserDefaults.standard.data(
			forKey: forKey
		) {
			return try? JSONDecoder().decode(T.self, from: data)
		}
		return nil
	}
	
	static func set<T: Encodable>(data: T, forKey: String) {
		UserDefaults.standard.set(try? JSONEncoder().encode(data), forKey: forKey)
	}
}
