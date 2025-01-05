//
//  AccentButtonView.swift
//  MobileAppDevIOS
//
//  Created by Rune Monsecour on 29/10/2024.
//

import SwiftUI

struct ButtonView: View {
	let text: String
	var action: (() -> Void)?
	
	var body: some View {
		Button(action: {if (action != nil) {action!()}}) {
			Text(text).frame(minWidth: 100).foregroundStyle(.white)
				.padding(.horizontal, 40).padding(.vertical, 10)
				.background(RoundedRectangle(cornerRadius: 10).fill(.accent))
				.padding(20)
		}.disabled(action == nil)
	}
}

#Preview {
	ButtonView(text: "hey")
}
