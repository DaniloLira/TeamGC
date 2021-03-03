//
//  History.swift
//  OuviFalar
//
//  Created by Pedro Moura on 02/03/21.
//

import SwiftUI

struct History {
    var title: String = ""
    var description: String = ""
}

var history: [History] = [
    History(
        title: "Cloroquina é recomendável para a Covid",
        description: "- Acreditamos que esse tema tem grande potencial de ser fake news e por isso não recomendamos seu compartilhamento."
    ),
    History(
        title: "Cloroquina pode causar infarto",
        description: "- Não encontramos indícios claros de que se trata de uma Fake News, mas recomendamos que você avalie a fonte antes de compartilhá-la."
    ),
    History(
        title: "Cloroquina é usada para Covid desde 2005",
        description: "- Acreditamos que esse tema tem grande potencial de ser fake news e por isso não recomendamos seu compartilhamento."
    )
]
