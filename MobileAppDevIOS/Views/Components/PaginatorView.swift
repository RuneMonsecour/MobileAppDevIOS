//
//  SwiftUIView.swift
//  MobileAppDevIOS
//
//  Created by Rune Monsecour on 05/01/2025.
//

import SwiftUI

struct PaginatorView: View {
	let onChangePage: (_ newOffset: Int) -> Void
	let offset: Int
	let number: Int
	let totalResults: Int
	
    var body: some View {
			HStack {
				Button(action: {onChangePage(offset - number)}) {
					Image(
						ImageResource.arrowDownKeyboard
					).imageScale(.large).rotationEffect(Angle.degrees(90))
				}.disabled(offset - number < 0)
				
				let dOffset = Double(offset)
				let dTotal = Double(totalResults)
				let dNumber = Double(max(1, number))
				
				let sCurrentPage = String(
					Int(ceil(dOffset/dNumber)) + 1
				)
				let sTotalPages = String(
					Int(ceil(dTotal/dNumber))
				)
				Text(
					sCurrentPage
					+ "/" +
					sTotalPages
				)
				
				Button(action: {onChangePage(offset + number)}) {
					Image(
						ImageResource.arrowDownKeyboard
					).imageScale(.large).rotationEffect(Angle.degrees(-90))
				}.disabled(offset + number > totalResults)
			}.frame(maxWidth: .infinity)
    }
}

