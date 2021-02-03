//
//  NatofyScreenshots.swift
//  NatofyTests
//
//  Created by Toni Sevener on 2/2/21.
//

import XCTest
@testable import Natofy

class NatofyScreenshots: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
         // Put teardown code here. This method is called after the invocation of each test method in the class.
         app.terminate()
     }

    func testTranslateFlow() throws {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let textEditor = app.textViews.element(matching: .any, identifier: AccessibilityIdentifiers.translateInputTextEditor.rawValue)
        let translateButton = app.buttons.element(matching: .any, identifier: AccessibilityIdentifiers.translateButton.rawValue)
        let translateOutputList = app.tables.element(matching: .any, identifier: AccessibilityIdentifiers.translateOutputList.rawValue)
        
        XCTAssertTrue(textEditor.waitForExistence(timeout: 5))
        attachScreenshot(name: "input-view")
        translateButton.tap()
        XCTAssertTrue(translateOutputList.waitForExistence(timeout: 5))
        attachScreenshot(name: "output-view")
    }
    
    private func attachScreenshot(name: String) {
         let screenshot = app.windows.firstMatch.screenshot()
         let attachment = XCTAttachment(screenshot: screenshot)
         attachment.name = name
         attachment.lifetime = .keepAlways
         add(attachment)
     }

}
