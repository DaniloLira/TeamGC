//
//  SearchingBank.swift
//  OuviFalar
//
//  Created by Danilo Araújo on 04/12/20.
//

import Foundation
import NaturalLanguage
import SwiftUI

class SearchingBank: ObservableObject {
    
    @Published var searchItem: Search?
    
    init(){
        
    }
}

enum Intent: String{
    case favor
    case contra
    case notícia
    case humor
    case outros
}

enum Information: String{
    case desinfo
    case info
    case outros
}

protocol ShareViewDelegate{
    func changeView()
}

class Search: ObservableObject{
    
    var text: String
    
    @Published var intent: Intent?
    
    @Published var information: Information?
    
    @Published var isConcluded = false
    
    @Published var theme: Theme?
    
    
    
    var delegate: ShareViewDelegate?
    
    init(text: String){
        self.text = text
        
        
    }
    
    init(text: String, delegate: ShareViewDelegate) {
        self.text = text
        self.delegate = delegate
        
    }
    func startSearch(){
        print("Started searching")
        do{
            let label = try TweetIntentClassifier(configuration: .init()).prediction(text: self.text)
            print("got label ", label.label)
            if let intent = Intent(rawValue: label.label) {
                self.intent = intent
            }
            else{
                self.intent = .outros
            }
            
            let desinfoLabel = try TweetDesinfoClassifier(configuration: .init()).prediction(text: self.text)
            print("got desinfo ", desinfoLabel.label)
            
            if let information = Information(rawValue: desinfoLabel.label){
                self.information = information
            }
            else{
                self.information = .outros
            }
            
            if self.information == .info{
                
                if self.intent == .favor || self.intent == .humor{
                    self.information = .desinfo
                }
                
                
            }
            
        }
        catch{
            print(error)
        }
        print("started timer")
        Timer.scheduledTimer(withTimeInterval: 5, repeats: false){_ in
            self.isConcluded = true
            print("end timer")
            self.delegate?.changeView()
        }
    }
}

class Theme: ObservableObject{
    
    var name: String
    
    @Published var textsArray: [String] = []
    
    init(name: String){
        
        self.name = name
    }
    
}

extension Color {
    static let primaryColor = Color(red: 0x66/0xff, green: 0x99/0xff, blue: 0xf2/0xff)
    
    static let darkYellowColor = Color(red: 0x89/0xff, green: 0x91/0xff, blue: 0xf08/0xff)
    
    static let lightYellowColor = Color(red: 0xf2/0xff, green: 0xdc/0xff, blue: 0x66/0xff)
}
