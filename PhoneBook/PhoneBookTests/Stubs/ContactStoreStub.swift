//
//  ContactStoreStub.swift
//  PhoneBookTests
//
//  Created by Anton Gorlov on 02.06.2022.
//

import Foundation
import Contacts
@testable import PhoneBook

class ContactStoreStub: IContactStore {
    
    func enumerateContacts(with fetchRequest: CNContactFetchRequest, usingBlock block: @escaping (CNContact, UnsafeMutablePointer<ObjCBool>) -> Void) throws {
        
        let stubContact = CNMutableContact()
        stubContact.givenName  = "ki45-efko-24gri-sglptrh-q001"
        let cnPhoneNumber      = CNPhoneNumber(stringValue: "3487drg-drgdr-43dgh-pawc4310")
        stubContact.phoneNumbers = [CNLabeledValue<CNPhoneNumber>(label: CNContactPhoneNumbersKey, value: cnPhoneNumber)]
        block(stubContact, UnsafeMutablePointer<ObjCBool>.allocate(capacity: 1))
    }
 
    func requestAccess(for entityType: CNEntityType, completionHandler: @escaping (Bool, Error?) -> Void) {
        
        completionHandler(true, nil)
    }
}
