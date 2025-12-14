//
//  CalendarView.swift
//  Calendar
//
//  Created by Bakhtovar Umarov on 12/13/25.
//
//

import SwiftUI

struct CalendarView: View {
    
    @StateObject var viewModel: CalendarViewModel
    let coordinator: AppCoordinator
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    init(
        service: WorkoutServiceProtocol,
        coordinator: AppCoordinator
    ) {
        _viewModel = StateObject(
            wrappedValue: CalendarViewModel(service: service)
        )
        self.coordinator = coordinator
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                monthHeader
                calendarCard
                workoutsCard
            }
            .padding(.top, 44)
            .padding(.horizontal)
            .padding(.bottom, 16)
        }
        .navigationTitle("Календарь")
        .accessibilityIdentifier("CalendarScreen")
        .navigationBarTitleDisplayMode(.large)
    }
}

private extension CalendarView {
    
    var monthHeader: some View {
        HStack {
            Button {
                viewModel.previousMonth()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title3)
            }
            .accessibilityIdentifier("PreviousMonthButton")
            
            Spacer()
            
            Text(viewModel.currentMonth, format: .dateTime.month(.wide).year())
                .font(.title3)
                .fontWeight(.semibold)
            
            Spacer()
            
            Button {
                viewModel.nextMonth()
            } label: {
                Image(systemName: "chevron.right")
                    .font(.title3)
            }
            .accessibilityIdentifier("NextMonthButton")
        }
        .padding(.horizontal, 4)
    }
}

private extension CalendarView {
    
    var calendarCard: some View {
        VStack(spacing: 12) {
            
            weekDaysHeader
            
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(viewModel.daysInMonth, id: \.self) { date in
                    dayCell(date)
                }
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

private extension CalendarView {
    
    var weekDaysHeader: some View {
        let symbols = Calendar.current.shortWeekdaySymbols
        
        return HStack {
            ForEach(symbols, id: \.self) { day in
                Text(day)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

private extension CalendarView {
    
    func dayCell(_ date: Date) -> some View {
        let calendar = Calendar.current
        let isSelected = calendar.isDate(date, inSameDayAs: viewModel.selectedDate)
        let isToday = calendar.isDateInToday(date)
        let hasWorkout = viewModel.hasWorkout(on: date)
        let isCurrentMonth = calendar.isDate(date, equalTo: viewModel.currentMonth, toGranularity: .month)
        
        return Button {
            viewModel.selectedDate = date
        } label: {
            VStack(spacing: 6) {
                
                Text(date, format: .dateTime.day())
                    .font(.body)
                    .fontWeight(isToday ? .bold : .regular)
                    .foregroundColor(
                        isSelected ? .white :
                            isCurrentMonth ? .primary : .secondary
                    )
                    .frame(width: 36, height: 36)
                    .background(
                        isSelected ? Color.accentColor :
                            isToday ? Color.accentColor.opacity(0.15) :
                            Color.clear
                    )
                    .clipShape(Circle())
                
                if hasWorkout {
                    Circle()
                        .frame(width: 6, height: 6)
                        .foregroundColor(.accentColor)
                }
            }
            .frame(height: 52)
        }
        .buttonStyle(.plain)
        .accessibilityIdentifier(
            "Day_\(Calendar.current.component(.year, from: date))_" +
            "\(Calendar.current.component(.month, from: date))_" +
            "\(Calendar.current.component(.day, from: date))"
        )
    }
}

private extension CalendarView {
    
    var workoutsCard: some View {
        let dayWorkouts = viewModel.workouts(for: viewModel.selectedDate)
        
        return VStack(alignment: .leading, spacing: 12) {
            
            Text("Тренировки")
                .font(.title3)
                .fontWeight(.semibold)
            
            if dayWorkouts.isEmpty {
                Text("Нет тренировок")
                    .foregroundColor(.secondary)
                    .padding(.vertical, 8)
            } else {
                ForEach(dayWorkouts) { workout in
                    workoutRow(workout)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

private extension CalendarView {
    
    func workoutRow(_ workout: WorkoutPreview) -> some View {
        Button {
            coordinator.openWorkout(workout)
        } label: {
            HStack(spacing: 12) {
                
                Circle()
                    .fill(color(for: workout.workoutActivityType))
                    .frame(width: 10, height: 10)
                
                VStack(alignment: .leading) {
                    Text(workout.workoutActivityType.rawValue)
                        .font(.body)
                        .fontWeight(.medium)
                    
                    Text(workout.workoutStartDate, format: .dateTime.hour().minute())
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
            }
            .padding(.vertical, 8)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityIdentifier("WorkoutCell")
    }
}

private extension CalendarView {
    
    func color(for type: WorkoutType) -> Color {
        switch type {
        case .walkingRunning: return .orange
        case .yoga: return .purple
        case .water: return .blue
        case .cycling: return .green
        case .strength: return .red
        }
    }
}
