//
//  DesignsPattersTests.swift
//  DesignsPattersTests
//
//  Created by Igor Lantushenko on 19/05/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import XCTest
@testable import DesignsPatters

class DesignsPattersTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testConcurrentAccess() {
        let aSynq = DispatchQueue(label: "async", attributes: .concurrent, target: nil)
        
        let expect = expectation(description: "Storing values in SessionState shall succeedd")
        
        let maxIndex = 5000
        
        for i in 0...maxIndex {
            aSynq.async {
                SessionState.shared.set(i, forKey: String(i))
                
            }
        }
        
        while SessionState.shared.object(forKey: String(maxIndex)) != maxIndex {
            
        }
        
        expect.fulfill()
        
        waitForExpectations(timeout: 10) { (error) in
            XCTAssertNil(error, "Test expaction failed")
            
        }
    }

    
}
