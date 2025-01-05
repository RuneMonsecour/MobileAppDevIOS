//
//  PreviewView.swift
//  MobileAppDevIOS
//
//  Created by Rune Monsecour on 28/10/2024.
//

import SwiftUI

struct PreviewView: View {
	@StateObject var router: Router
	let viewModelFactory: ViewModelFactory
	
	var body: some View {
		MainView()
			.environmentObject(viewModelFactory).environmentObject(router)
	}
	
	init(route: ERoute = .recipes) {
		let viewModelFactory = ViewModelFactory()
		_router = StateObject(wrappedValue: Router(
			viewModelFactory: viewModelFactory,
			defaultRoute: route
		)
		)
		self.viewModelFactory = viewModelFactory
	}
}

#Preview {
	PreviewView()
}

