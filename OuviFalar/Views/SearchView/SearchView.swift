//
//  SearchView.swift
//  OuviFalar
//
//  Created by Danilo Araújo on 04/12/20.
//

import SwiftUI

struct SearchView: View {
    
    @State var searchText: String = ""
    @State private var selectedCategory = 0
    @State private var isPickerShown: Bool = false

    var category = ["Cloroquina", "Vacina", "Covid"]
   
    let textField = UITextView()
    
    var body: some View {
        ZStack(alignment: .bottom){
            VStack{
                SelectCategory(isPickerShown: $isPickerShown, selectedCategory: $selectedCategory, category: category)
                Spacer()
                SearchBox(searchText: $searchText)
                    .padding(.bottom)
            }
            .modifier(MainModifier(isPickerShown: $isPickerShown))
            
            VStack{
                Picker(selection: $selectedCategory, label: Text("Selecione a categoria: ")) {
                    ForEach(0 ..< category.count) {
                        Text(self.category[$0])
                    }
                }
                .modifier(PickerModifier())
            }
            .modifier(PickerStackModifier(isPickerShown: $isPickerShown))
        }
        .modifier(NavigationViewModifier())
    }
    
}

struct WaitingView: View {
    
    var body: some View {
        
        Text("Outra tela")
        
    }
}

struct SearchBox: View {
    @Binding var searchText: String
    var body: some View {
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
            .frame(height: 300)
            
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
        Spacer()
    }
}

struct SelectCategory: View {
    @Binding var isPickerShown: Bool
    @Binding var selectedCategory: Int
    var category: [String]
    var body: some View {
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
        .shadow(color: .gray, radius: 3, x: 0, y: 2)
    }
}

//struct History: View {
//    var body: some View {
//        HStack {
//            Text("Histórico")
//                .font(.headline)
//            Spacer()
//        }
//
//        .padding([.top, .leading])
//
//        ScrollView(.horizontal) {
//            LazyHStack(spacing: 1) {
//
//                ForEach(0..<(historico.count)){ index in
//
//                    VStack{
//                        HStack {
//                            Text(historico[index].title)
//                                .fontWeight(.bold)
//                                .foregroundColor(.white)
//                                .padding([.top, .leading, .trailing])
//                            Image(systemName: "xmark.circle")
//                                .padding()
//                                .foregroundColor(.red)
//
//                            Spacer()
//                        }
//
//
//                        Text(historico[index].description)
//                            .padding([.leading, .bottom, .trailing])
//                            .padding(.top, 5)
//                            .foregroundColor(Color(.systemGray6))
//
//                        Spacer()
//                    }
//
//                    .frame(maxWidth: 320)
//                    .background(Color.primaryColor)
//                    .cornerRadius(20)
//                    .padding()
//
//                }
//            }
//        }
//    }
//}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            SearchView()
        }
    }
}
