//
//  UITests.swift
//  UI Tests
//
//  Created by Eugenia Ostrovska on 4/8/21.
//  Copyright © 2021 Masilotti.com. All rights reserved.
//

import XCTest

class UITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()

    }

    override func tearDownWithError() throws {
        
    }
    

    func testManageTeam() throws {
        
        
        XCTAssert(app.staticTexts["Manage Team"].exists)
        XCTAssert(app.staticTexts["Manage Roster"].exists)
        XCTAssert(app.staticTexts["View Schedule"].exists)
        
//        Open Manage Team page
        app.staticTexts["Manage Team"].tap()
        
//        Check the page has opened
        XCTAssert(app.navigationBars["Manage Team"].exists)
        
//        Set formation picker to 6 attackers and 1 setter
        let firstPredicate = NSPredicate(format: "label CONTAINS 'Attackers'")
        let firstPicker = app.pickerWheels.element(matching: firstPredicate)
        firstPicker.adjust(toPickerWheelValue: "6 attackers")
        
        let secondPredicate = NSPredicate(format: "label = 'Setters Formation'")
        let secondPicker = app.pickerWheels.element(matching: secondPredicate)
        secondPicker.adjust(toPickerWheelValue: "1 setter")
        
//        Check that Formation label has been updated
        XCTAssert(app.staticTexts["6 attackers, 1 setter"].exists)
        
//        Swipe the slider to the right
        let skillSlider = app.sliders.element
        skillSlider.adjust(toNormalizedSliderPosition: 0.8)
        
//        Check that Skill Level label has been updated
        XCTAssert(app.staticTexts["8"].exists)
    }
    
    
    
    func testManageSchedule() throws{
        
//         Open View Schedule page
        app.staticTexts["View Schedule"].tap()
        
//         Check the page has opened
        XCTAssert(app.navigationBars["Schedule"].exists)
        
//         Tap “Finish Game”
        let finishGameButton = app.buttons["Finish Game"]
        finishGameButton.tap()
        
//         Verify alert info
        XCTAssert(app.alerts["You won!"].exists)
        
//         Dismiss alert
        app.alerts["You won!"].buttons["Awesome!"].tap()
        
//         Tap “Load more games”
        let loadMoreGames = app.buttons["Load More Games"]
        loadMoreGames.tap()
        
//         Verify that loading label is shown
        let loadingLabel = app.staticTexts["Loading..."]
        XCTAssert(loadingLabel.waitForExistence(timeout: 5))
        
//         Wait till Game 4 appears
        let nextGameLabel = app.staticTexts["Game 4 - Tomorrow"]
        XCTAssert(nextGameLabel.waitForExistence(timeout: 5))
        
//         Tap “Find Games Nearby”
        let findGamesNearby = app.buttons["Find Games Nearby?"]
        findGamesNearby.tap()
        
//         Tap Allow is the System Alert
        addUIInterruptionMonitor(withDescription: "Location Services") { (alert) -> Bool in
          alert.buttons["Allow While Using App"].tap()
          return true
        }

        app.tap()
        
//         Verify that location access has been authorized
        XCTAssert(app.staticTexts["Authorized"].waitForExistence(timeout: 5))
    }

}
