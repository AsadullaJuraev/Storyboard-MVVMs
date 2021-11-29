//
//  StoryboardContactUITests.swift
//  StoryboardContactUITests
//
//  Created by Asadulla Juraev on 03/11/21.
//

import XCTest
import StoryboardContact

class StoryboardContactUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
    }
    
    //MARK: TASK -CONTACT LIST-
    
    func testWithTableViewExist() throws{
        app.launch()
        
        let ex = expectation(description: "testWithTableViewExist")
        
        AFHttp.get(url: AFHttp.API_CONTACT_LIST, params: AFHttp.paramsEmpty()) { response in
            switch response.result {
            case .success:
                XCTAssertTrue(self.app.tables.element.exists)
                ex.fulfill()
            case let .failure(error) :
                XCTAssertNil(error)
                ex.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }
    
    func testWithTableViewCellCount() throws{
        app.launch()
        
        let ex = expectation(description: "testWithTableViewCellCount")
        
        AFHttp.get(url: AFHttp.API_CONTACT_LIST, params: AFHttp.paramsEmpty()) { response in
            switch response.result {
            case .success:
                XCTAssertEqual(self.app.tables.cells.count, 3)
                ex.fulfill()
            case let .failure(error) :
                XCTAssertNil(error)
                ex.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }
    
    //MARK: TASK -CONTACT EDIT-
    
    func testWithCallSingleContact() throws {
        app.launch()
        let ex = expectation(description: "testWithCallSingleContact")
        let id = 2
        AFHttp.get(url: AFHttp.API_CONTACT_SINGLE + String(id), params: AFHttp.paramsContactWith(id: id)) { response in
            switch response.result {
            case .success:
                let object = try! JSONDecoder().decode(Contact.self, from: response.data!)
                XCTAssertNotNil(object.name)
                ex.fulfill()
            case let .failure(error):
                XCTAssertNil(error)
                ex.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }
    
    func testWithEditContact() throws {
        app.launch()
        let ex = expectation(description: "testWithEditContact")
        let id = 2
        let contact = Contact(name: "Name Test", number: "+99891294328112")
        AFHttp.get(url: AFHttp.API_CONTACT_SINGLE + String(id), params: AFHttp.paramsContactUpdate(contact: contact)) { response in
            switch response.result {
            case .success:
                let object = try! JSONDecoder().decode(Contact.self, from: response.data!)
                XCTAssertTrue((object.name != nil), "Name Test")
                XCTAssertTrue((object.number != nil), "+99891294328112")
                ex.fulfill()
            case let .failure(error):
                XCTAssertNil(error)
                ex.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }
    
    //MARK: -OTHER-
    
    func testWithStaticText() throws{
        app.launch()
        XCTAssertTrue(app.staticTexts["Contact list"].exists)
    }
    
    func testWithNavigationTitle() throws {
        app.launch()
        XCTAssert(app.navigationBars["Contact list"].exists)
    }
    

}
