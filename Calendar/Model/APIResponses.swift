//
//  APIResponses.swift
//  Calendar
//
//  Created by Bakhtovar Umarov on 12/13/25.
//

import Foundation

// MARK: - List workouts

struct WorkoutListResponse: Decodable {
    let data: [WorkoutPreview]
}

// MARK: - Metadata

struct MetadataResponse: Decodable {
    let workouts: [String: WorkoutMetadata]
}

// MARK: - Diagram

struct DiagramResponse: Decodable {
    let workouts: [String: DiagramWorkout]
}

struct DiagramWorkout: Decodable {
    let data: [DiagramPoint]
}
