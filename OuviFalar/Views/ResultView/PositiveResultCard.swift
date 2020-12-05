//
//  ResultCard.swift
//  OuviFalar
//
//  Created by Pedro Henrique Spínola de Assis on 04/12/20.
//

import SwiftUI

struct PositiveResultCard: View {
    let color = Color(red: 0x66/0xff, green: 0x99/0xff, blue: 0xf2/0xff)
    var textoPesquisado: String = "Coloquina mata"
    
    var body: some View {
        VStack{
            Text("\"\(textoPesquisado)\"")
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .padding(.top, 30.0)
            
            Spacer()
                .frame(height: 35)
            
            Image("PositiveResult")
                .padding()
            
            
            Text("Acreditamos que esse tema tem grande potencial de ser verídico, mas recomendamos que você avalie a fonte antes de compartilhá-la.")
                .multilineTextAlignment(.center)
                .foregroundColor(Color.white)
                .frame(width: 290.0)
                .padding()
            
        Spacer()
            .frame(height: 35)
            
        }
        .frame(width: 350, alignment: .center)
        .background(color).cornerRadius(15)
    }
}

struct PositiveResultCard_Previews: PreviewProvider {
    static var previews: some View {
        PositiveResultCard()
    }
}