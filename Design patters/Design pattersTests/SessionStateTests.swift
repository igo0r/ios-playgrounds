//
//  Design_pattersTests.swift
//  Design pattersTests
//
//  Created by Igor Lantushenko on 19/05/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import XCTest
@testable import Design

class SessionStateTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testConcurrentAccess() {
        let asyncQueue = DispatchQueue(label: "asyncQueue")
        
        let expect = expectation(description: "Storing values in SessionState shall succeedd")
        
        let maxIndex = 200
        
        for i in 0...maxIndex {
            asyncQueue.async {
                SessionState.shared.set(i, forKey: "\(i)")
                
            }
        }
        
        while SessionState.shared.object(forKey: "\(maxIndex)") != "\(maxIndex)" {
            
        }
        
        expect.fullfill()
        
        waitForExpactions(timeout: 10) { (error) in
            XCTAssertNill(error, "Test expaction failed")
            
        }
    }
    
}
