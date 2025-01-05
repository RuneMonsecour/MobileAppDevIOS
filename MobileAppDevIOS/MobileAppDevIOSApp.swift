//
//  MobileAppDevIOSApp.swift
//  MobileAppDevIOS
//
//  Created by Rune Monsecour on 25/10/2024.
//

import SwiftUI

@main
struct MobileAppDevIOSApp: App {
	@StateObject var router: Router
	let viewModelFactory: ViewModelFactory
	
	init() {
		let viewModelFactory = ViewModelFactory()
		_router = StateObject(wrappedValue: Router(
			viewModelFactory: viewModelFactory,
			defaultRoute: .recipes
		)
		)
		self.viewModelFactory = viewModelFactory
	}
	
    var body: some Scene {
        WindowGroup {
					MainView()
        }.environmentObject(viewModelFactory).environmentObject(router)
    }
}
