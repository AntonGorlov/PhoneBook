//
//  ViewController.swift
//  PhoneBook
//
//  Created by Anton Gorlov on 02.06.2022.
//

import UIKit

class ViewController: UIViewController {

    private let contactManager: IContactsManager = ContactsManager.default()
    private var allContacts                      = [ContactsObject]()
    var isGetContacts                            = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.getContacts()
    }
    
    //MARK: - Get all contacts
        
        func getContacts() {
            
            let status = contactManager.authorizationStatus()
            
            switch status {
                
            case .authorized:
                
                fetchContacts()
                break
                
            case .notDetermined:
                
                fetchContacts()
                break
                
            default:
                
                break
            }
        }
        
        private func fetchContacts() {
            
            contactManager.fetchContacts { [weak self] (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        
                        self?.isGetContacts = false
                        
                        print("User not opened contacts: \(error)")
                    case .success(let contacts):
                        
                        self?.isGetContacts = true
                        self?.allContacts = contacts
                        
                        print("Contacts:\(contacts)")
                    }
                }
            }
        }

}

