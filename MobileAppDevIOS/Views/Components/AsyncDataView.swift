//
//  AsyncData.swift
//  MobileAppDevIOS
//
//  Created by Rune Monsecour on 27/10/2024.
//

import SwiftUI

struct AsyncDataView<Content: View>: View {
	var isLoading: Bool
	let isLoadingMessage: String
	var error: String?
	let content: () -> Content
	
	var body: some View {
		if isLoading {
			ProgressView(isLoadingMessage).frame(maxHeight: .infinity)
		} else if let error = error {
			Text(error)
				.foregroundStyle(.red)
				.frame(maxHeight: .infinity)
		} else {
			content()
		}
	}
}

#Preview {
	AsyncDataView(
		isLoading: true,
		isLoadingMessage: "Laden...",
		error: nil
	) {
		Text("Data")
	}
}
