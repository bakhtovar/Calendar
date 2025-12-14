//
//  HeartRateScatterChart.swift
//  Calendar
//
//  Created by Bakhtovar Umarov on 12/13/25.
//

import SwiftUI
import Charts

struct HeartRateScatterChart: View {
    
    let points: [DiagramPoint]
    
    private var minHR: Int {
        points.map(\.heartRate).min() ?? 0
    }
    
    private var maxHR: Int {
        points.map(\.heartRate).max() ?? 0
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            // Header
            VStack(alignment: .leading, spacing: 4) {
                Text("Пульс")
                    .font(.headline)
                
                Text("\(minHR)–\(maxHR) BPM")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Chart(points) {
                PointMark(
                    x: .value("Time", $0.timeNumeric),
                    y: .value("Heart Rate", $0.heartRate)
                )
                .symbolSize(45)
                .foregroundStyle(.red)
            }
            .chartXAxis {
                AxisMarks(values: .automatic(desiredCount: 4)) {
                    AxisGridLine()
                        .foregroundStyle(.secondary.opacity(0.25))
                    AxisValueLabel()
                        .foregroundStyle(.secondary)
                }
            }
            .chartYAxis {
                AxisMarks(position: .trailing) {
                    AxisGridLine()
                        .foregroundStyle(.secondary.opacity(0.25))
                    AxisValueLabel()
                        .foregroundStyle(.secondary)
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
