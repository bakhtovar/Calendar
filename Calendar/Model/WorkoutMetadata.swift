//
//  WorkoutMetadata.swift
//  Calendar
//
//  Created by Bakhtovar Umarov on 12/13/25.
//

import Foundation

struct WorkoutMetadata: Identifiable, Codable {
    let workoutKey: String
    let workoutActivityType: WorkoutType
    let workoutStartDate: Date
    let distance: String
    let duration: String
    let maxLayer: Int
    let maxSubLayer: Int
    let avgHumidity: String
    let avgTemp: String
    let comment: String?
    let photoBefore: String?
    let photoAfter: String?
    let heartRateGraph: String?
    let activityGraph: String?
    let map: String?

    var id: String { workoutKey }

    enum CodingKeys: String, CodingKey {
        case workoutKey
        case workoutActivityType
        case workoutStartDate
        case distance
        case duration
        case maxLayer
        case maxSubLayer
        case avgHumidity = "avg_humidity"
        case avgTemp = "avg_temp"
        case comment
        case photoBefore
        case photoAfter
        case heartRateGraph
        case activityGraph
        case map
    }
}
