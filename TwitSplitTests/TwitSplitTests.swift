//
//  TwitSplitTests.swift
//  TwitSplitTests
//
//  Created by Lu Kien Quoc on 1/31/19.
//  Copyright © 2019 Lu Kien Quoc. All rights reserved.
//

import XCTest
@testable import TwitSplit

class TwitSplitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
//    func testExample() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
    // input example message
    func testExampleMessage() {
        let input = "I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself."
        let expected = ["1/2 I can't believe Tweeter now supports chunking",
                        "2/2 my messages, so I don't have to do it myself."]
        
        let output = Base.splitMessage(input)
        
        XCTAssertEqual(output, expected)
    }

    // input message length less than limit character
    func testMessageLessThanLimit() {
        let input = "I can't believe Tweeter now supports chunking mes"
        let expected = ["I can't believe Tweeter now supports chunking mes"]
        
        let output = Base.splitMessage(input)
        
        XCTAssertEqual(output, expected)
    }
    
    // input message length reach the limit character
    func testMessageReachLimit() {
        let input = "I can't believe Tweeter now supports chunking mess"
        let expected = ["I can't believe Tweeter now supports chunking mess"]
        
        let output = Base.splitMessage(input)
        
        XCTAssertEqual(output, expected)
    }
    
    // input message with a span of non-whitespace characters longer than the limit character
    func testInvalidSpanOfNonWhitespace() {
        let input = "Ican'tbelieveTweeternowsupportschunkingmymessages,soIdon'thavetodoitmyself."
        let expected = [String]()
        
        let output = Base.splitMessage(input)
        
        XCTAssertEqual(output, expected)
    }
    
    // input message is empty
    func testEmptyMessage() {
        let input = ""
        let expected = [String]()

        let output = Base.splitMessage(input)
        
        XCTAssertEqual(output, expected)
        
    }
    
    // input message contains a span of non-whitespace characters longer than the limit character after a valid word
    func testInvalidSpanOfNonWhitespaceAfterAValidWord() {
        let input = "I can't believeTweeternowsupportschunkingmymessages,soIdon'thavetodoitmyself."
        let expected = [String]()
        
        let output = Base.splitMessage(input)
        
        XCTAssertEqual(output, expected)
    }
    
    // input message will split more than 10 chunks
    func testMoreThanTenChunks() {
        let input = "I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself.I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself.I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself.I can't believe Tweeter now supports chunking my abc xyz aaaa, so I don't have to do it myself.I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself."
        
        let expected = ["1/11 I can't believe Tweeter now supports chunking",
                        "2/11 my messages, so I don't have to do it",
                        "3/11 myself.I can't believe Tweeter now supports",
                        "4/11 chunking my messages, so I don't have to do",
                        "5/11 it myself.I can't believe Tweeter now",
                        "6/11 supports chunking my messages, so I don't",
                        "7/11 have to do it myself.I can't believe Tweeter",
                        "8/11 now supports chunking my abc xyz aaaa, so I",
                        "9/11 don't have to do it myself.I can't believe",
                        "10/11 Tweeter now supports chunking my messages,",
                        "11/11 so I don't have to do it myself."]
  
        let output = Base.splitMessage(input)
        
        XCTAssertEqual(output, expected)
    }
    
    // input message with a span of whitespace characters which can split into a chunk
    func testASpanOfWhitepspaceInAChunk() {
        let input = "I can't                \n               believe Tweeter now supports chunking my messages, so I don't have to do it myself."
        let expected = ["1/3 I can't                \n               believe",
                        "2/3 Tweeter now supports chunking my messages, so",
                        "3/3 I don't have to do it myself."]
        
        let output = Base.splitMessage(input)
        
        XCTAssertEqual(output, expected)
    }
    
    // input message with a span of whitespace characters at the split position
    // input message end with a span of whitespace characters
    func testEndWithASpanOfWhitepspaces() {
        let input = "I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself. I can't believe Tweeter now supports chunking         \n          "
        let expected = ["1/3 I can't believe Tweeter now supports chunking",
                        "2/3 my messages, so I don't have to do it myself.",
                        "3/3 I can't believe Tweeter now supports chunking"]
        
        let output = Base.splitMessage(input)
        
        XCTAssertEqual(output, expected)
    }
    
    // input message start with a span of whitespace characters
    func testStartWithASpanOfWhitepspaces() {
        let input = "            I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself."
        let expected = ["1/2 I can't believe Tweeter now supports chunking",
                        "2/2 my messages, so I don't have to do it myself."]
        
        let output = Base.splitMessage(input)
        
        XCTAssertEqual(output, expected)
    }

}
