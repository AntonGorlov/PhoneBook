//
//  ContactsObject.swift
//  PhoneBook
//
//  Created by Anton Gorlov on 02.06.2022.
//

import Foundation

/// A phone book current user
///# Include
/// * First name
/// * Phone numbers

struct ContactsObject {
    
    let firstName   : String
    let numberPhones: String
    
    func AddPhoneBookRequestDataFactory() -> AddPhoneBookRequestData {
        
        return AddPhoneBookRequestData(firstName: firstName,
                                       numberPhones: numberPhones)
    }
}

struct AddPhoneBookRequestData: Encodable {
    
    let firstName   : String
    let numberPhones: String

    enum CodingKeys: String, CodingKey {
        
        case firstName    = "name"
        case numberPhones = "phoneNumber"
    }

    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(numberPhones, forKey: .numberPhones)
    }
}
