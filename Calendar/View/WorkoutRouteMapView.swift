//
//  WorkoutRouteMapView.swift
//  Calendar
//
//  Created by Bakhtovar Umarov on 12/13/25.
//

import SwiftUI
import MapKit

struct WorkoutRouteMapView: View {

    let coordinates: [CLLocationCoordinate2D]

    @State private var cameraPosition: MapCameraPosition = .automatic

    var body: some View {
        Map(position: $cameraPosition) {

            if coordinates.count > 1 {

                // Маршрут
                MapPolyline(coordinates: coordinates)
                    .stroke(.blue, lineWidth: 4)

                // Старт
                Annotation("Start", coordinate: coordinates.first!) {
                    startPin
                }

                // Финиш
                Annotation("Finish", coordinate: coordinates.last!) {
                    finishPin
                }
            }
        }
        .onAppear {
            updateCamera()
        }
        .onTapGesture {
            openInMaps()
        }
        .frame(height: 240)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}


private extension WorkoutRouteMapView {

    func updateCamera() {
        guard !coordinates.isEmpty else { return }

        let region = MKCoordinateRegion(
            boundingCoordinates: coordinates,
            padding: 1.4
        )

        cameraPosition = .region(region)
    }
}

private extension WorkoutRouteMapView {

    var startPin: some View {
        Image(systemName: "play.circle.fill")
            .font(.title)
            .foregroundColor(.green)
            .background(Color.white.clipShape(Circle()))
    }

    var finishPin: some View {
        Image(systemName: "stop.circle.fill")
            .font(.title)
            .foregroundColor(.red)
            .background(Color.white.clipShape(Circle()))
    }
}

private extension WorkoutRouteMapView {

    func openInMaps() {
        guard
            let start = coordinates.first,
            let finish = coordinates.last
        else { return }

        let startItem = MKMapItem(
            placemark: MKPlacemark(coordinate: start)
        )
        startItem.name = "Старт"

        let finishItem = MKMapItem(
            placemark: MKPlacemark(coordinate: finish)
        )
        finishItem.name = "Финиш"

        MKMapItem.openMaps(
            with: [startItem, finishItem],
            launchOptions: [
                MKLaunchOptionsDirectionsModeKey:
                    MKLaunchOptionsDirectionsModeWalking
            ]
        )
    }
}
