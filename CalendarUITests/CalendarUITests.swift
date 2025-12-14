//
//  CalendarUITests.swift
//  CalendarUITests
//
//  Created by Bakhtovar Umarov on 12/13/25.
//

import XCTest

final class CalendarUITests: XCTestCase {

    private var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    // MARK: - App launch

    func testCalendarScreenIsShown() {
        let calendarScreen = app.navigationBars["Календарь"]
        XCTAssertTrue(calendarScreen.exists)
    }

    // MARK: - Day selection shows workouts

    func testSelectNovember11AndShowWorkout() {
        let app = XCUIApplication()
        app.launch()

        let previousMonthButton = app.buttons["PreviousMonthButton"]

        for _ in 0..<12 {
            if app.buttons["Day_2025_11_25"].exists {
                break
            }
            previousMonthButton.tap()
        }

        let dayButton = app.buttons["Day_2025_11_25"]
        XCTAssertTrue(dayButton.waitForExistence(timeout: 2))
        dayButton.tap()

        let workoutCell = app.buttons["WorkoutCell"]
        XCTAssertTrue(
            workoutCell.waitForExistence(timeout: 2),
            "Workout cell should appear for 25 Nov 2025"
        )
    }

    // MARK: - Navigation to workout details

    func testOpenWorkoutDetailsFromNovember25() {
        let app = XCUIApplication()
        app.launch()
        
        let previousMonthButton = app.buttons["PreviousMonthButton"]
        
        for _ in 0..<12 {
            if app.buttons["Day_2025_11_25"].exists {
                break
            }
            previousMonthButton.tap()
        }
        
        app.buttons["Day_2025_11_25"].tap()
        
        let workoutCell = app.buttons["WorkoutCell"].firstMatch
        XCTAssertTrue(workoutCell.waitForExistence(timeout: 2))
        
        workoutCell.tap()
    }
}
