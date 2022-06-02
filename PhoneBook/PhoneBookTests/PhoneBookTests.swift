//
//  PhoneBookTests.swift
//  PhoneBookTests
//
//  Created by Anton Gorlov on 02.06.2022.
//

import XCTest
import Contacts
@testable import PhoneBook

class PhoneBookTests: XCTestCase {

    var sut: IContactsManager!
    
    override func setUp() {
        
        let storeStub = ContactStoreStub()
        self.sut      = ContactsManager(contactsStore: storeStub)
    }
    
    /// - **Summary**: Test a fatching contact by ContactsManager
    /// - **System under test**: ContactsObject method fetchContacts
    /// - **Preconditions**: ContactStoreStub uuid mathes uuid from this test
    /// - **Conditions to test**: ContactsManager method fetchContacts return expected object ([ContactsObject])
    /// # Test scenario
    /// - 1: Call method fetchContacts
    /// - 2: Assert given data

    func testPhoneBook() {
        
        let expectation     = XCTestExpectation()
        var resultConctacts = [ContactsObject]()
        
        sut.fetchContacts { (result) in
            
            switch result{
            case .success(let contacts):
                
                resultConctacts = contacts
                
            case .failure(let error):
                
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(resultConctacts.count, 1)
        XCTAssertEqual(resultConctacts[0].firstName,    "ki45-efko-24gri-sglptrh-q001")
        XCTAssertEqual(resultConctacts[0].numberPhones, "3487drg-drgdr-43dgh-pawc4310")
    }
}
