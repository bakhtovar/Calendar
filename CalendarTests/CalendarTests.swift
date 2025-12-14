//
//  CalendarTests.swift
//  CalendarTests
//
//  Created by Bakhtovar Umarov on 12/13/25.
//

import XCTest
@testable import Calendar

final class CalendarViewModelTests: XCTestCase {

    private var viewModel: CalendarViewModel!
    private var service: MockWorkoutService!

    override func setUp() {
        super.setUp()
        service = MockWorkoutService()
        viewModel = CalendarViewModel(service: service)
    }

    override func tearDown() {
        viewModel = nil
        service = nil
        super.tearDown()
    }

    // MARK: - Filtering

    func testWorkoutsFilteredBySelectedDay() {
        let calendar = Calendar.current
        let date = calendar.date(
            from: DateComponents(year: 2025, month: 11, day: 25)
        )!

        viewModel.selectedDate = date

        let workouts = viewModel.workouts(for: date)

        XCTAssertEqual(workouts.count, 2)

        XCTAssertTrue(
            workouts.allSatisfy {
                calendar.isDate(
                    $0.workoutStartDate,
                    inSameDayAs: date
                )
            }
        )
    }

    // MARK: - Month switching

    func testNextMonthChangesCurrentMonth() {
        let currentMonth = viewModel.currentMonth

        viewModel.nextMonth()
        
        XCTAssertNotEqual(viewModel.currentMonth, currentMonth)
    }

    func testPreviousMonthChangesCurrentMonth() {
        let currentMonth = viewModel.currentMonth

        viewModel.previousMonth()

        XCTAssertNotEqual(viewModel.currentMonth, currentMonth)
    }

    // MARK: - Date formatting

    func testMonthTitleFormatting() {
        let title = viewModel.currentMonth
            .formatted(.dateTime.month(.wide).year())

        XCTAssertFalse(title.isEmpty)
    }
}
