//
//  WorkoutDetailsView.swift
//  Calendar
//
//  Created by Bakhtovar Umarov on 12/13/25.
//

import SwiftUI
import Charts
import MapKit

struct WorkoutDetailsView: View {
    
    @StateObject var viewModel: WorkoutDetailsViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                
                header
                
                metricsCard
                
                if !viewModel.diagram.isEmpty {
                    HeartRateScatterChart(points: viewModel.diagram)
                    SpeedAreaChart(points: viewModel.diagram)
                }
                
                if !viewModel.routeCoordinates.isEmpty {
                    routeMap
                }
                
                if let comment = viewModel.metadata?.comment,
                   !comment.isEmpty {
                    commentSection(comment)
                }
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
        }
        .accessibilityIdentifier("WorkoutDetailsScreen")
    }
}

private extension WorkoutDetailsView {
    
    var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(viewModel.workout.workoutActivityType.rawValue)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text(
                viewModel.workout.workoutStartDate,
                format: .dateTime.month(.abbreviated).day().year().hour().minute()
            )
            .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private extension WorkoutDetailsView {
    
    var metricsCard: some View {
        VStack(spacing: 16) {
            
            metricRow(
                title: "Длительность",
                value: viewModel.durationText
            )
            
            metricRow(
                title: "Дистанция",
                value: viewModel.distanceText
            )
            
            if let temp = viewModel.metadata?.avgTemp {
                metricRow(
                    title: "Средняя температура",
                    value: "\(temp) °C"
                )
            }
            
            if let humidity = viewModel.metadata?.avgHumidity {
                metricRow(
                    title: "Влажность",
                    value: "\(humidity) %"
                )
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    func metricRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .fontWeight(.semibold)
        }
    }
}

private extension WorkoutDetailsView {
    
    var routeMap: some View {
        chartCard(title: "Маршрут") {
            WorkoutRouteMapView(
                coordinates: viewModel.routeCoordinates
            )
        }
    }
}

private extension WorkoutDetailsView {
    
    func commentSection(_ text: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Комментарий")
                .font(.headline)
            
            Text(text)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

private extension WorkoutDetailsView {
    
    func chartCard<Content: View>(
        title: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            
            Text(title)
                .font(.headline)
            
            content()
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
