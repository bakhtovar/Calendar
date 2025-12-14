//
//  WorkoutDetailsViewModel.swift
//  Calendar
//
//  Created by Bakhtovar Umarov on 12/13/25.
//

import Foundation
import CoreLocation
import Combine

final class WorkoutDetailsViewModel: ObservableObject {

    let workout: WorkoutPreview
    let metadata: WorkoutMetadata?
    let diagram: [DiagramPoint]

    init(
        workout: WorkoutPreview,
        service: WorkoutServiceProtocol
    ) {
        self.workout = workout
        self.metadata = service.fetchMetadata(workoutKey: workout.workoutKey)
        self.diagram = service.fetchDiagram(workoutKey: workout.workoutKey)
    }

    var routeCoordinates: [CLLocationCoordinate2D] {
        diagram
            .filter { $0.latitude != 0 && $0.longitude != 0 }
            .map(\.coordinate)
    }
}

extension WorkoutDetailsViewModel {

    var durationText: String {
        guard
            let durationString = metadata?.duration,
            let duration = Double(durationString)
        else {
            return "—"
        }

        let minutes = Int(duration / 60)
        return "\(minutes) мин"
    }

    var distanceText: String {
        guard
            let distanceString = metadata?.distance,
            let distance = Double(distanceString)
        else {
            return "—"
        }

        let km = distance / 1000
        return String(format: "%.2f км", km)
    }
}
