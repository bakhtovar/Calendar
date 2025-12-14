//
//  CalendarViewModel.swift
//  Calendar
//
//  Created by Bakhtovar Umarov on 12/13/25.
//

import Foundation
import Combine

final class CalendarViewModel: ObservableObject {

    @Published var currentMonth: Date = Date()
    @Published var selectedDate: Date = Date()
    @Published var workouts: [WorkoutPreview] = []

    private let service: WorkoutServiceProtocol
    private let calendar = Calendar.current

    init(service: WorkoutServiceProtocol) {
        self.service = service
        self.workouts = service.fetchWorkouts()
    }

    // MARK: - Calendar helpers

    var daysInMonth: [Date] {
        guard
            let monthInterval = calendar.dateInterval(of: .month, for: currentMonth),
            let firstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start),
            let lastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.end)
        else { return [] }

        return calendar.generateDates(
            inside: DateInterval(start: firstWeek.start, end: lastWeek.end),
            matching: DateComponents(hour: 0, minute: 0)
        )
    }

    func workouts(for date: Date) -> [WorkoutPreview] {
        workouts.filter {
            calendar.isDate($0.workoutStartDate, inSameDayAs: date)
        }
    }

    func hasWorkout(on date: Date) -> Bool {
        !workouts(for: date).isEmpty
    }

    // MARK: - Month navigation

    func nextMonth() {
        currentMonth = calendar.date(byAdding: .month, value: 1, to: currentMonth)!
    }

    func previousMonth() {
        currentMonth = calendar.date(byAdding: .month, value: -1, to: currentMonth)!
    }
}
