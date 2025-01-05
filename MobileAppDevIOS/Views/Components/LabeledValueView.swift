//
//  LabeledValueView.swift
//  MobileAppDevIOS
//
//  Created by Rune Monsecour on 29/10/2024.
//

import SwiftUI

struct LabeledValueView: View {
	let label: String
	let value: String
	
    var body: some View {
			HStack {
				Text(label)
					.foregroundStyle(.secondaryText)
					.frame(maxWidth: 100, alignment: .leading)
				Text(value)
					.foregroundStyle(.primaryText)
					.frame(maxWidth: .infinity, alignment: .leading)
			}.padding(.horizontal).padding(.vertical, 20)
    }
}

#Preview {
	LabeledValueView(label: "lab", value: "val")
}
