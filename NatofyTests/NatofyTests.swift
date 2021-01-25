//
//  NatofyTests.swift
//  NatofyTests
//
//  Created by Toni Sevener on 1/24/21.
//

import XCTest

class NatofyTests: XCTestCase {

    func testNatoConverter() {
        let testString = "The quick 2 brown f0x 1 JUMPS over 3 the lazy-dog. 456789!👨‍👩‍👧‍👧"
        let result = NatoConverter.convert(text: testString)
        XCTAssertEqual(result.count, 59)
        XCTAssertEqual(result[0].long, "Tango")
        XCTAssertEqual(result[1].long, "Hotel")
        XCTAssertEqual(result[2].long, "Echo")
        XCTAssertEqual(result[3].long, " ")
        XCTAssertEqual(result[4].long, "Quebec")
        XCTAssertEqual(result[5].long, "Uniform")
        XCTAssertEqual(result[6].long, "India")
        XCTAssertEqual(result[7].long, "Charlie")
        XCTAssertEqual(result[8].long, "Kilo")
        XCTAssertEqual(result[9].long, " ")
        XCTAssertEqual(result[10].long, "Two")
        XCTAssertEqual(result[11].long, " ")
        XCTAssertEqual(result[12].long, "Bravo")
        XCTAssertEqual(result[13].long, "Romeo")
        XCTAssertEqual(result[14].long, "Oscar")
        XCTAssertEqual(result[15].long, "Whiskey")
        XCTAssertEqual(result[16].long, "November")
        XCTAssertEqual(result[17].long, " ")
        XCTAssertEqual(result[18].long, "Foxtrot")
        XCTAssertEqual(result[19].long, "Zero")
        XCTAssertEqual(result[20].long, "X-ray")
        XCTAssertEqual(result[21].long, " ")
        XCTAssertEqual(result[22].long, "One")
        XCTAssertEqual(result[23].long, " ")
        XCTAssertEqual(result[24].long, "Juliett")
        XCTAssertEqual(result[25].long, "Uniform")
        XCTAssertEqual(result[26].long, "Mike")
        XCTAssertEqual(result[27].long, "Papa")
        XCTAssertEqual(result[28].long, "Sierra")
        XCTAssertEqual(result[29].long, " ")
        XCTAssertEqual(result[30].long, "Oscar")
        XCTAssertEqual(result[31].long, "Victor")
        XCTAssertEqual(result[32].long, "Echo")
        XCTAssertEqual(result[33].long, "Romeo")
        XCTAssertEqual(result[34].long, " ")
        XCTAssertEqual(result[35].long, "Three")
        XCTAssertEqual(result[36].long, " ")
        XCTAssertEqual(result[37].long, "Tango")
        XCTAssertEqual(result[38].long, "Hotel")
        XCTAssertEqual(result[39].long, "Echo")
        XCTAssertEqual(result[40].long, " ")
        XCTAssertEqual(result[41].long, "Lima")
        XCTAssertEqual(result[42].long, "Alpha")
        XCTAssertEqual(result[43].long, "Zulu")
        XCTAssertEqual(result[44].long, "Yankee")
        XCTAssertEqual(result[45].long, "Dash")
        XCTAssertEqual(result[46].long, "Delta")
        XCTAssertEqual(result[47].long, "Oscar")
        XCTAssertEqual(result[48].long, "Golf")
        XCTAssertEqual(result[49].long, ".")
        XCTAssertEqual(result[50].long, " ")
        XCTAssertEqual(result[51].long, "Four")
        XCTAssertEqual(result[52].long, "Five")
        XCTAssertEqual(result[53].long, "Six")
        XCTAssertEqual(result[54].long, "Seven")
        XCTAssertEqual(result[55].long, "Eight")
        XCTAssertEqual(result[56].long, "Nine")
        XCTAssertEqual(result[57].long, "!")
        XCTAssertEqual(result[58].long, "👨‍👩‍👧‍👧")
    }

}
