//
//  SwyngCMSUnitTest.swift
//  SwyngTests
//
//  Created by Dixit Rathod on 01/06/21.
//

import XCTest
@testable import Swyng

class SwyngCMSUnitTest: XCTestCase {

    func test_is_ValidCMSData(){
        let cmsVM = CMSViewModel()
        cmsVM.type.accept(.aboutSwyng)
        let expect = self.expectation(description: "ValidCMSData")
        cmsVM.getCMSPageData {
            XCTAssertEqual("", cmsVM.alert.value)
            XCTAssertNotEqual("", cmsVM.content.value)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 5)
    }
    
    func test_is_InvalidCMSData(){
        let cmsVM = CMSViewModel()
        cmsVM.type.accept(.privacy)
        let expect = self.expectation(description: "InvalidCMSData")
        cmsVM.getCMSPageData {
            XCTAssertNotEqual("", cmsVM.alert.value)
            XCTAssertEqual("No data available", cmsVM.content.value)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 5)
    }
}
