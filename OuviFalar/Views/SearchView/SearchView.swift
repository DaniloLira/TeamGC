//
//  SearchView.swift
//  OuviFalar
//
//  Created by Danilo Araújo on 04/12/20.
//

import SwiftUI

struct SearchView: View {
    
    @State var searchText: String = ""
    
    var category = ["Cloroquina", "Vacina", "Covid"]
    @State private var selectedCategory = 0
    
    @State private var isPickerShown: Bool = false
    
    struct  Historico {
        var title: String = ""
        var description: String = ""
    }
    
    var historico: [Historico] = [Historico(title: "Cloroquina é recomendável para a Covid", description: "- Acreditamos que esse tema tem grande potencial de ser fake news e por isso não recomendamos seu compartilhamento."), Historico(title: "Cloroquina pode causar infarto", description: "- Não encontramos indícios claros de que se trata de uma Fake News, mas recomendamos que você avalie a fonte antes de compartilhá-la."), Historico(title: "Cloroquina é usada para Covid desde 2005", description: "- Acreditamos que esse tema tem grande potencial de ser fake news e por isso não recomendamos seu compartilhamento.")]
    
    let textField = UITextView()
    
    
    var body: some View {
        ZStack(alignment: .bottom){
            VStack{
                
                HStack(){
                    Text("Selecione a categoria")
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Spacer()
                }
                .padding()
                Button(action:{
                    isPickerShown = true
                }){
                    HStack{
                        Spacer()
                        Text(category[selectedCategory])
                            .padding()
                            .foregroundColor(.primary)
                        Spacer()
                    }
                }
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
                
                HStack(){
                    Text("O que tu ouviu falar?")
                        .font(.title3)
                        .fontWeight(.semibold)
                    Spacer()
                }
                .padding([.leading, .top])
                
                TextEditor(text: $searchText)
                    .cornerRadius(5)
                    .border(Color(.systemGray3))
                    .padding(.horizontal)
                
                
                NavigationLink(destination: WaitingRoomView(item: Search(text: searchText))){
                    Text("Checar")
                        .padding()
                        .padding(.horizontal, 40)
                        .background(Color.primaryColor)
                        .foregroundColor(Color(.systemBackground))
                        .cornerRadius(10)
                        .shadow(radius: 7)
                }
                .padding(.top)
                .disabled(searchText.isEmpty)
                HStack {
                    Text("Histórico")
                        .font(.headline)
                    Spacer()
                }
                
                .padding([.top, .leading])
                
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 1) {
                        
                        ForEach(0..<(historico.count)){ index in
                            
                            VStack{
                                HStack {
                                    Text(historico[index].title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .padding([.top, .leading, .trailing])
                                    Image(systemName: "xmark.circle")
                                        .padding()
                                        .foregroundColor(.red)
                                    
                                    Spacer()
                                }
                                
                                
                                Text(historico[index].description)
                                    .padding([.leading, .bottom, .trailing])
                                    .padding(.top, 5)
                                    .foregroundColor(Color(.systemGray6))
                                
                                Spacer()
                            }
                            
                            .frame(maxWidth: 320)
                            .background(Color.primaryColor)
                            .cornerRadius(20)
                            .padding()
                            
                        }
                    }
                }
                
                
            }
            .resingKeyboardOnTapGesture()
            .blur(radius: isPickerShown ? 3.0 : 0)
            .disabled(isPickerShown)
            .onTapGesture {
                if isPickerShown{
                    isPickerShown = false
                }
            }
            
            VStack{
                Picker(selection: $selectedCategory, label: Text("Selecione a categoria: ")) {
                    ForEach(0 ..< category.count) {
                        Text(self.category[$0])
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .padding()
            }
            .background(Color(.systemGray6))
            .offset(y: isPickerShown ? 0 : UIScreen.main.bounds.height)
            .animation(.spring())
            
            
        }
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

struct WaitingView: View {
    
    var body: some View {
        
        Text("Outra tela")
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            SearchView()
        }
    }
}
