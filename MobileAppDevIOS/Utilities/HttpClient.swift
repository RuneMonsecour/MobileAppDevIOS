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
			"x-api-key": "dbb43716ad724a4da009b1f921c985e7"
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
	
	func get<T: Decodable>(endpoint: String, queryItems: [URLQueryItem]? = nil) async -> Result<T> {
		do {
			var components = URLComponents(url: baseURL.appendingPathComponent(endpoint), resolvingAgainstBaseURL: true)!
			
			components.queryItems = queryItems
			
			guard let url = components.url else {
				return .failure(500, "Wrong URL")
			}
			
			let (data, response) = try await session.data(
				from: url
			)
	
			guard let httpResponse = response as? HTTPURLResponse else {
				return .failure(500, "Wrong server response.")
			}
			
			if (200...299).contains(httpResponse.statusCode) {
				let decodedObject = try JSONDecoder().decode(T.self, from: data)
				return .success(httpResponse.statusCode, decodedObject)
			} else {
				return .failure(
					httpResponse.statusCode,
					String(httpResponse.statusCode) + ": " + HttpClient
						.getMessageFromStatusCode(code: httpResponse.statusCode))
			}
		} catch {
			return .failure(400, "Network error")
		}
	}
	
	static func getMessageFromStatusCode(code: Int) -> String {
		let dict = [
			404: "Not found.",
			429: "Sent too many requests. Please wait a bit.",
		]
		return dict[code] ?? "Something wnet wrong."
	}
}


