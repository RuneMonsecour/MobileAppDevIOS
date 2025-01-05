//
//  Main.swift
//  MobileAppDevIOS
//
//  Created by Rune Monsecour on 26/10/2024.
//

import SwiftUI

struct MainView: View {
	@EnvironmentObject var router: Router

	var body: some View {
			VStack(spacing: 0) {
				
					router
					.getView(route: router.currentRoute)
						
				
				NavMenuView().transaction { transaction in
					transaction.animation = nil
				}
				
			}
			.background(.whiteLightest)
			.id(router.pageId)
			.transition(
				router.currentRoute == router.previousRoute ? .opacity : router.currentRoute
					.getIndex() > router.previousRoute
					.getIndex() ? .slideLeading : .slideTrailing
			).edgesIgnoringSafeArea(.bottom)
	}
}

#Preview {
	PreviewView()
}

