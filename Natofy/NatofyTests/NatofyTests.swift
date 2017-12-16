//
//  NatofyTests.swift
//  NatofyTests
//
//  Created by Toni Sevener on 12/12/17.
//  Copyright © 2017 Toni Sevener. All rights reserved.
//

import XCTest
@testable import Natofy

class NatofyTests: XCTestCase {
    
    func testNatoConverter() {
        let testString = "The quick 2 brown f0x 1 JUMPS over 3 the lazy-dog. 456789!👨‍👩‍👧‍👧"
        let result = NatoConverter.convert(text: testString)
        XCTAssertEqual(result.count, 59)
        XCTAssertEqual(result[0], "Tango")
        XCTAssertEqual(result[1], "Hotel")
        XCTAssertEqual(result[2], "Echo")
        XCTAssertEqual(result[3], " ")
        XCTAssertEqual(result[4], "Quebec")
        XCTAssertEqual(result[5], "Uniform")
        XCTAssertEqual(result[6], "India")
        XCTAssertEqual(result[7], "Charlie")
        XCTAssertEqual(result[8], "Kilo")
        XCTAssertEqual(result[9], " ")
        XCTAssertEqual(result[10], "Two")
        XCTAssertEqual(result[11], " ")
        XCTAssertEqual(result[12], "Bravo")
        XCTAssertEqual(result[13], "Romeo")
        XCTAssertEqual(result[14], "Oscar")
        XCTAssertEqual(result[15], "Whiskey")
        XCTAssertEqual(result[16], "November")
        XCTAssertEqual(result[17], " ")
        XCTAssertEqual(result[18], "Foxtrot")
        XCTAssertEqual(result[19], "Zero")
        XCTAssertEqual(result[20], "X-ray")
        XCTAssertEqual(result[21], " ")
        XCTAssertEqual(result[22], "One")
        XCTAssertEqual(result[23], " ")
        XCTAssertEqual(result[24], "Juliett")
        XCTAssertEqual(result[25], "Uniform")
        XCTAssertEqual(result[26], "Mike")
        XCTAssertEqual(result[27], "Papa")
        XCTAssertEqual(result[28], "Sierra")
        XCTAssertEqual(result[29], " ")
        XCTAssertEqual(result[30], "Oscar")
        XCTAssertEqual(result[31], "Victor")
        XCTAssertEqual(result[32], "Echo")
        XCTAssertEqual(result[33], "Romeo")
        XCTAssertEqual(result[34], " ")
        XCTAssertEqual(result[35], "Three")
        XCTAssertEqual(result[36], " ")
        XCTAssertEqual(result[37], "Tango")
        XCTAssertEqual(result[38], "Hotel")
        XCTAssertEqual(result[39], "Echo")
        XCTAssertEqual(result[40], " ")
        XCTAssertEqual(result[41], "Lima")
        XCTAssertEqual(result[42], "Alpha")
        XCTAssertEqual(result[43], "Zulu")
        XCTAssertEqual(result[44], "Yankee")
        XCTAssertEqual(result[45], "Dash")
        XCTAssertEqual(result[46], "Delta")
        XCTAssertEqual(result[47], "Oscar")
        XCTAssertEqual(result[48], "Golf")
        XCTAssertEqual(result[49], ".")
        XCTAssertEqual(result[50], " ")
        XCTAssertEqual(result[51], "Four")
        XCTAssertEqual(result[52], "Five")
        XCTAssertEqual(result[53], "Six")
        XCTAssertEqual(result[54], "Seven")
        XCTAssertEqual(result[55], "Eight")
        XCTAssertEqual(result[56], "Nine")
        XCTAssertEqual(result[57], "!")
        XCTAssertEqual(result[58], "👨‍👩‍👧‍👧")
    }
    
}
