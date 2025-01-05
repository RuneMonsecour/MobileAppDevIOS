//
//  DividerView.swift
//  MobileAppDevIOS
//
//  Created by Rune Monsecour on 29/10/2024.
//

import SwiftUI

struct DividerView: View {
	var fill: Color = .whiteDark
	var width: CGFloat = 1.5
	
    var body: some View {
			Rectangle()
				.fill(fill)
				.frame(height: width)
				.edgesIgnoringSafeArea(.horizontal)
    }
}

#Preview {
	DividerView()
}
