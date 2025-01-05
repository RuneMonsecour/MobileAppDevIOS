//
//  HttpClient.swift
//  MobileAppDevIOS
//
//  Created by Rune Monsecour on 05/01/2025.
//

import Foundation

class HttpClient {
	static let spoonacular = HttpClient(
		baseUrl: "https://api.spoonacular.com/",
		headers: [
			"Content-Type": "application/json",
			"x-api-key": "dabdd47c37094522bc4857a71d09ddce"
		]
	)
	
	private let session: URLSession
	private let baseURL: URL
	
	private init(baseUrl: String, headers: [AnyHashable : Any]? = nil) {
		self.baseURL = URL(string: baseUrl)!
		
		let configuration = URLSessionConfiguration.default
		configuration.httpAdditionalHeaders = headers
		
		self.session = URLSession(configuration: configuration)
	}
	
	func get<T: Decodable>(endpoint: String) async -> Result<T> {
		do {
			let (data, response) = try await session.data(
				from: baseURL.appending(path: endpoint)
			)
	
			guard let httpResponse = response as? HTTPURLResponse else {
				return .failure(500, "Verkeerd server antwoord.")
			}
			
			if (200...299).contains(httpResponse.statusCode) {
				let decodedObject = try JSONDecoder().decode(T.self, from: data)
				return .success(httpResponse.statusCode, decodedObject)
			} else {
				return .failure(httpResponse.statusCode, String(httpResponse.statusCode) + ": Er ging iets fout.")
			}
		} catch {
			return .failure(400, "Netwerk fout")
		}
	}
}


