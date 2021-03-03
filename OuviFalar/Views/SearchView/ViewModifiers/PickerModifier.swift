//
//  PickerModifier.swift
//  OuviFalar
//
//  Created by Pedro Moura on 02/03/21.
//

import SwiftUI

struct PickerModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .pickerStyle(WheelPickerStyle())
            .padding()
    }
}

struct PickerStackModifier: ViewModifier {
    @Binding var isPickerShown: Bool
    func body(content: Content) -> some View {
        content
            .background(Color(.systemGray6))
            .offset(y: isPickerShown ? 0 : UIScreen.main.bounds.height)
            .animation(.spring())
    }
}
