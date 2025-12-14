//
//  KCoordinateRegion+Bounding.swift
//  Calendar
//
//  Created by Bakhtovar Umarov on 12/13/25.
//

import MapKit

extension MKCoordinateRegion {

    init(boundingCoordinates coordinates: [CLLocationCoordinate2D], padding: Double) {
        let latitudes = coordinates.map(\.latitude)
        let longitudes = coordinates.map(\.longitude)

        let minLat = latitudes.min() ?? 0
        let maxLat = latitudes.max() ?? 0
        let minLon = longitudes.min() ?? 0
        let maxLon = longitudes.max() ?? 0

        let span = MKCoordinateSpan(
            latitudeDelta: (maxLat - minLat) * padding,
            longitudeDelta: (maxLon - minLon) * padding
        )

        let center = CLLocationCoordinate2D(
            latitude: (minLat + maxLat) / 2,
            longitude: (minLon + maxLon) / 2
        )

        self.init(center: center, span: span)
    }
}
