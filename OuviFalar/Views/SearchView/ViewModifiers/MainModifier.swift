//
//  MainModifier.swift
//  OuviFalar
//
//  Created by Pedro Moura on 02/03/21.
//

import SwiftUI

struct MainModifier: ViewModifier {
    @Binding var isPickerShown: Bool
    func body(content: Content) -> some View {
        content
            .resingKeyboardOnTapGesture()
            .blur(radius: isPickerShown ? 3.0 : 0)
            .disabled(isPickerShown)
            .onTapGesture {
                if isPickerShown{
                    isPickerShown = false
                }
            }
    }
}
