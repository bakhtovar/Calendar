//
//  DiagramPoint.swift
//  Calendar
//
//  Created by Bakhtovar Umarov on 12/13/25.
//

import Foundation
import CoreLocation

struct DiagramPoint: Identifiable, Codable {
    let timeNumeric: Int
    let heartRate: Int
    let speedKmh: Double
    let distanceMeters: Int
    let steps: Int
    let elevation: Double
    let latitude: Double
    let longitude: Double
    let temperatureCelsius: Double
    let currentLayer: Int
    let currentSubLayer: Int
    let currentTimestamp: Date

    var id: Int { timeNumeric }

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude
        )
    }
    
    enum CodingKeys: String, CodingKey {
        case timeNumeric = "time_numeric"
        case heartRate
        case speedKmh = "speed_kmh"
        case distanceMeters
        case steps
        case elevation
        case latitude
        case longitude
        case temperatureCelsius
        case currentLayer
        case currentSubLayer
        case currentTimestamp
    }
}
