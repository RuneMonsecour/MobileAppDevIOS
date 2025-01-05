//
//  AnyTransition.swift
//  MobileAppDevIOS
//
//  Created by Rune Monsecour on 30/10/2024.
//

import SwiftUI

extension AnyTransition {
	static var slideTrailing: AnyTransition {
		AnyTransition.asymmetric(
			insertion: .move(edge: .leading),
			removal: .move(edge: .trailing))
	}
	
	static var slideLeading: AnyTransition {
		AnyTransition.asymmetric(
			insertion: .move(edge: .trailing),
			removal: .move(edge: .leading))
	}
}
