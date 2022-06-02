//
//  IContactStore.swift
//  PhoneBook
//
//  Created by Anton Gorlov on 02.06.2022.
//

import Foundation
import Contacts

/// This protocol for a TESTABILITY CNContactStore !
/// Get a user phone book

protocol IContactStore {
    
    func requestAccess(for entityType: CNEntityType, completionHandler: @escaping (Bool, Error?) -> Void)
    
    func enumerateContacts(with fetchRequest: CNContactFetchRequest, usingBlock block: @escaping (CNContact, UnsafeMutablePointer<ObjCBool>) -> Void) throws
}

extension CNContactStore: IContactStore { }
