//
//  MockWorkoutService.swift
//  Calendar
//
//  Created by Bakhtovar Umarov on 12/13/25.
//

import Foundation
import SwiftUI

protocol WorkoutServiceProtocol {
    func fetchWorkouts() -> [WorkoutPreview]
    func fetchMetadata(workoutKey: String) -> WorkoutMetadata?
    func fetchDiagram(workoutKey: String) -> [DiagramPoint]
}

final class MockWorkoutService: WorkoutServiceProtocol {

    private let workouts: [WorkoutPreview]
    private let metadata: [String: WorkoutMetadata]
    private let diagrams: [String: [DiagramPoint]]

    init() {
        let listResponse: WorkoutListResponse = JSONLoader.load("list_workouts")
        let metadataResponse: MetadataResponse = JSONLoader.load("metadata")
        let diagramResponse: DiagramResponse = JSONLoader.load("diagram_data")

        self.workouts = listResponse.data
        self.metadata = metadataResponse.workouts
        self.diagrams = diagramResponse.workouts.mapValues { $0.data }
    }

    func fetchWorkouts() -> [WorkoutPreview] {
        workouts
    }

    func fetchMetadata(workoutKey: String) -> WorkoutMetadata? {
        metadata[workoutKey]
    }

    func fetchDiagram(workoutKey: String) -> [DiagramPoint] {
        diagrams[workoutKey] ?? []
    }
}

final class JSONLoader {

    static func load<T: Decodable>(_ filename: String) -> T {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            fatalError("❌ Не найден файл \(filename).json")
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(DateFormatter.api)
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("❌ Ошибка парсинга \(filename): \(error)")
        }
    }
}
