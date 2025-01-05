//
//  NavItemView.swift
//  MobileAppDevIOS
//
//  Created by Rune Monsecour on 28/10/2024.
//

import SwiftUI

struct NavItemView: View {
	let route: ERoute
	let onClick: (ERoute) -> Void
	let isSelected: Bool
	let icons: (default: ImageResource, selected: ImageResource)
	
	var body: some View {
		Button(action: {onClick(route)}) {
			VStack{
				Image(isSelected ? icons.selected : icons.default).imageScale(.large)
				Text(route.rawValue)
			}
			.foregroundStyle(isSelected ? .accent : .primaryText)
			.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
		}.frame(maxWidth: .infinity, maxHeight: 45)
	}
}

#Preview {
	PreviewView()
}
