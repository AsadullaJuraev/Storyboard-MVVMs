//
//  StoryboardContactTests.swift
//  StoryboardContactTests
//
//  Created by Asadulla Juraev on 03/11/21.
//

import XCTest
@testable import StoryboardContact

class StoryboardContactTests: XCTestCase {

    func testContactListApiResponseNotNil(){
        let ex = expectation(description: "testContactListApiResponseNotNil")
        
        AFHttp.get(url: AFHttp.API_CONTACT_LIST, params: AFHttp.paramsEmpty()) { response in
            switch response.result {
            case .success:
                XCTAssertNotNil(response)
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
    
    func testContactCreateApiResponseNotNil(){
        let ex = expectation(description: "testContactCreateApiResponseNotNil")
        let contact = Contact(name: "Jaguar", number: "+998912345678")
        AFHttp.post(url: AFHttp.API_CONTACT_CREATE, params: AFHttp.paramsContactCreate(contact: contact)) { response in
            switch response.result {
            case .success:
                XCTAssertNotNil(response)
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

    func testContactEditApiResponse(){
        let ex = expectation(description: "testContactEditApiResponse")
        let contact = Contact(name: "Jaguary Edit", number: "+998912345687")
        let id = "2"
        AFHttp.put(url: AFHttp.API_CONTACT_UPDATE + id, params: AFHttp.paramsContactUpdate(contact: contact)) { response in
            switch response.result {
            case .success:
                XCTAssertNotNil(response)
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
    
    func testContactDeleteApiResonse(){
        let ex = expectation(description: "testContactEditApiResponse")
        let id = "4"
        AFHttp.del(url: AFHttp.API_CONTACT_DELETE + id, params: AFHttp.paramsEmpty(), handler: { response in
            switch response.result {
            case .success:
                XCTAssertNotNil(response)
                ex.fulfill()
            case let .failure(error):
                XCTAssertNil(error)
                ex.fulfill()
            }
        })
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }
    
}
