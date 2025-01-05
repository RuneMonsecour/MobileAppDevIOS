//
//  Result.swift
//  MobileAppDevIOS
//
//  Created by Rune Monsecour on 05/01/2025.
//

import Foundation

class Result<T> {
	private let data: T?
	let error: String?
	let statusCode: Int
	
	private init(statusCode: Int, data: T? = nil, error: String? = nil) {
		self.data = data
		self.error = error
		self.statusCode = statusCode
	}
	
	static func success(_ statusCode: Int, _ data: T) -> Result<T> {
		return Result(statusCode: statusCode, data: data)
	}
	
	static func failure(_ statusCode: Int, _ error: String) -> Result<T> {
		return Result(statusCode: statusCode, error: error)
	}
	
	func isSuccess() -> Bool {
		return self.data != nil && self.error == nil
	}
	
	func isFailure() -> Bool {
		return !self.isSuccess()
	}
	
	func getData() -> T {
		return self.data!
	}
}
