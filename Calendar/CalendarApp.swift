//
//  CalendarApp.swift
//  Calendar
//
//  Created by Bakhtovar Umarov on 12/13/25.
//

import SwiftUI
import CoreData

@main
struct CalendarApp: App {
    
    @StateObject private var coordinator =
    AppCoordinator(service: MockWorkoutService())
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                
                CalendarView(
                    service: coordinator.service,
                    coordinator: coordinator
                )
                .navigationDestination(
                    isPresented: $coordinator.isWorkoutActive
                ) {
                    if let workout = coordinator.selectedWorkout {
                        WorkoutDetailsView(
                            viewModel: WorkoutDetailsViewModel(
                                workout: workout,
                                service: coordinator.service
                            )
                        )
                    }
                }
            }
        }
    }
}
