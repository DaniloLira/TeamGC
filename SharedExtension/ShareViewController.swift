//
//  ShareViewController.swift
//  SharedExtension
//
//  Created by Samuel Brasileiro on 06/12/20.
//

import UIKit
import SwiftUI
import MobileCoreServices

@objc(ShareExtensionViewController)
class ShareViewController: UIViewController, ShareViewDelegate {
    var searchItem: Search?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.handleSharedFile()
    }
    
    private func handleSharedFile() {

        let attachments = (self.extensionContext?.inputItems.first as? NSExtensionItem)?.attachments ?? []
        let contentType = kUTTypeText as String
        for provider in attachments {

            if provider.hasItemConformingToTypeIdentifier(contentType) {
                provider.loadItem(forTypeIdentifier: contentType,
                                  options: nil) { [unowned self] (data, error) in
                    guard error == nil else { return }
                    
                    if var text = data as? String{
                        text = text.split(separator: "\n").joined(separator: " ")
                        self.save(text, key: "start-text-key")
                    
                    } else {
                        print("Impossible to save text")
                        return
                    }
                }}
        }
    }
    
    private func save(_ value: Any, key: String) {
        let userDefaults = UserDefaults(suiteName: "group.br.ufpe.academy.OuviFalar2")
        userDefaults!.set(value, forKey: key)
        print(userDefaults?.string(forKey: key) as Any)
        searchItem = Search(text: (userDefaults?.string(forKey: key))!, delegate: self)
        DispatchQueue.main.async{
            let waitingRoomView = UIHostingController(rootView: WaitingRoomView(item: self.searchItem!))
            self.addChild(waitingRoomView)
            waitingRoomView.view.translatesAutoresizingMaskIntoConstraints = false
            
            self.view.addSubview(waitingRoomView.view)
            let constraints = [
                waitingRoomView.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
                waitingRoomView.view.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor, constant: 0),
                waitingRoomView.view.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
                waitingRoomView.view.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
                waitingRoomView.view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            ]
            NSLayoutConstraint.activate(constraints)
        }
        
    }
    
    
    func changeView() {
        print("Changed View")
        let resultView = UIHostingController(rootView: ResultView(item: searchItem!))
        self.addChild(resultView)
        resultView.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(resultView.view)
        
        let constraints = [
            resultView.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            resultView.view.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor, constant: 0),
            resultView.view.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            resultView.view.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            resultView.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}
