//
//  WorkoutPreview.swift
//  Calendar
//
//  Created by Bakhtovar Umarov on 12/13/25.
//

import Foundation

struct WorkoutPreview: Decodable, Identifiable, Hashable {

    let workoutKey: String
    let workoutActivityType: WorkoutType
    let workoutStartDate: Date

    var id: String { workoutKey }
}
