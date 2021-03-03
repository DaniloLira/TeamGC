//
//  NavigationViewModifier.swift
//  OuviFalar
//
//  Created by Pedro Moura on 02/03/21.
//

import SwiftUI

struct NavigationViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationTitle("Pesquisa")
            .navigationBarHidden(false)
            .onAppear{
    //            let userDefaults = UserDefaults(suiteName: "group.br.ufpe.academy.OuviFalar")
    //            if let text = userDefaults?.string(forKey: "start-text-key"){
    //                searchText = text
    //            }
            }
    }
}
