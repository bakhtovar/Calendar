//
//  SpeedAreaChart.swift
//  Calendar
//
//  Created by Bakhtovar Umarov on 12/13/25.
//

import SwiftUI
import Charts

struct SpeedAreaChart: View {
    
    let points: [DiagramPoint]
    
    private var maxSpeed: Double {
        points.map(\.speedKmh).max() ?? 0
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            // Header
            VStack(alignment: .leading, spacing: 4) {
                Text("Скорость")
                    .font(.headline)
                
                Text("км/ч")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Chart(points) {
                
                // Gradient fill
                AreaMark(
                    x: .value("Time", $0.timeNumeric),
                    y: .value("Speed", $0.speedKmh)
                )
                .interpolationMethod(.catmullRom)
                .foregroundStyle(
                    LinearGradient(
                        colors: [
                            Color.blue.opacity(0.35),
                            Color.blue.opacity(0.05)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                
                // Line on top
                LineMark(
                    x: .value("Time", $0.timeNumeric),
                    y: .value("Speed", $0.speedKmh)
                )
                .interpolationMethod(.catmullRom)
                .lineStyle(StrokeStyle(lineWidth: 3))
                .foregroundStyle(.blue)
            }
            .chartYAxis {
                AxisMarks(position: .trailing) {
                    AxisGridLine()
                        .foregroundStyle(.secondary.opacity(0.25))
                    AxisValueLabel()
                        .foregroundStyle(.secondary)
                }
            }
            .chartXAxis {
                AxisMarks(values: .automatic(desiredCount: 4)) {
                    AxisGridLine()
                        .foregroundStyle(.secondary.opacity(0.25))
                }
            }
            .frame(height: 200)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
        )
    }
}
