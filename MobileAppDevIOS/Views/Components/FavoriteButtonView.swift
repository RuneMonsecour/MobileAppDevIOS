//
//  FavoriteButton.swift
//  MobileAppDevIOS
//
//  Created by Rune Monsecour on 05/01/2025.
//

import SwiftUI

struct FavoriteButtonView: View {
	let action: () -> Void
	let isFavorite: Bool
	
    var body: some View {
			Button(action: {action()}) {
				Image(
					isFavorite ? .starFillIcon : .starIcon
				).imageScale(.large).foregroundStyle(
					isFavorite ? .accent : .primaryText
				)
			}
    }
}

