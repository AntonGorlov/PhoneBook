//
//  ContactsManager.swift
//  PhoneBook
//
//  Created by Anton Gorlov on 02.06.2022.
//

import Foundation
import Contacts

/// This protocol gets a users phone book if user gave the contacts permission
protocol IContactsManager {
    func fetchContacts(completion: @escaping (Result<[ContactsObject], Error>) -> Void)
    func authorizationStatus() -> CNAuthorizationStatus
}

/// This manager gets a user phone book
final class ContactsManager: IContactsManager {
    
    private(set) var store: IContactStore
    
    static func `default`() -> ContactsManager {
        
        return ContactsManager()
    }
    
    private init () {
        
        self.store = CNContactStore()
    }
    
    init(contactsStore: IContactStore) {
        
        self.store = contactsStore
    }
    
    /// Fetch contacts
    /// - Parameter completion: .failure: error, .success: ContactsObject
    
    func fetchContacts(completion: @escaping (Result<[ContactsObject], Error>) -> Void) {
        store.requestAccess(for: .contacts) { [weak self] _, err in
            if let error = err {
                completion(.failure(error))
                return
            }
            self?.requestContacts(completion: completion)
        }
    }
    
    /// Check an authorization status
    /// CNAuthorizationStatus
    
    func authorizationStatus() -> CNAuthorizationStatus {
        
        return CNContactStore.authorizationStatus(for: .contacts)
    }
}
    
private extension ContactsManager {
    
    /// Get a phone book with parameters
    /// - Parameter completion: .failure: error, .success: ContactsObject
    /// # Success:
    /// ContactsObject: Mappeble
    /// # Error:
    /// Protocol Error
    /// # Keys:
    ///        CNContactGivenNameKey,
    ///        CNContactPhoneNumbersKey
    
    func requestContacts(completion: @escaping((Result<[ContactsObject], Error>) -> Void)) {
        
        var contacts = [CNContact]()
        
        let keys = [CNContactGivenNameKey,
                    CNContactPhoneNumbersKey]
        
        let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
        request.sortOrder = .givenName
        
        do {
            try self.store.enumerateContacts(with: request, usingBlock: { (contact, _) in
                if !contact.phoneNumbers.isEmpty {
                    contacts.append(contact)
                }
            })
        } catch let error {
            completion(.failure(error))
        }
        let formattedContacts = convertContacts(contacts: contacts)
        completion(.success(formattedContacts))
    }
    
    func convertContacts(contacts: [CNContact]) -> [ContactsObject] {
        
        var newCreditContacts = [ContactsObject]()
        
        for contact in contacts {
            let phone = contact.phoneNumbers[0].value.stringValue
           
            let newCreditContact = ContactsObject(firstName: contact.givenName,
                                                  numberPhones: phone)
            
            newCreditContacts.append(newCreditContact)
        }
        return newCreditContacts
    }
}
