//
//  AppCoordinator.swift
//  Calendar
//
//  Created by Bakhtovar Umarov on 12/13/25.
//

import SwiftUI
import Combine
import Foundation

final class AppCoordinator: ObservableObject {

    // MARK: - Navigation state
    @Published var selectedWorkout: WorkoutPreview?
    @Published var isWorkoutActive = false

    // MARK: - Dependencies
    let service: WorkoutServiceProtocol

    init(service: WorkoutServiceProtocol) {
        self.service = service
    }

    // MARK: - Navigation actions
    func openWorkout(_ workout: WorkoutPreview) {
        selectedWorkout = workout
        isWorkoutActive = true
    }

    func popWorkout() {
        isWorkoutActive = false
        selectedWorkout = nil
    }
}
