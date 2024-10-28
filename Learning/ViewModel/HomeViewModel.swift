
// HomeViewModel.swift
import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var homeModel = HomeModel()
    @Published var selectedDate = Date()
    @Published var circleColor: Color = .clear
    
    private var calendar = Calendar.current
    
    // Function to log "Learned Today" with condition
    func logTodayAsLearned() {
        homeModel.todayLearned.toggle()
        
        if homeModel.todayLearned {
            circleColor = Color.orange.opacity(0.4)
            homeModel.previousStreak = homeModel.streak
            homeModel.streak += 1
        } else {
            homeModel.streak = homeModel.previousStreak
            circleColor = .clear
        }
    }
    
    // Function to freeze a day if conditions are met
    func freezeDay() {
        if !homeModel.todayLearned, homeModel.freezesUsed < homeModel.maxFreezes {
            homeModel.freezeLearned = true
            homeModel.freezesUsed += 1
            circleColor = Color.blue.opacity(0.4)
            homeModel.previousFreezesUsed = homeModel.freezesUsed
        }
    }
    
    // Reset freeze if freeze condition is canceled
    func resetFreeze() {
        homeModel.freezeLearned = false
        homeModel.todayLearned = false
        circleColor = .clear
        homeModel.freezesUsed = homeModel.previousFreezesUsed
    }
    
    // Check if a date is in the future
    func isFuture(date: Date) -> Bool {
        return date > Date()
    }
    
    // Check if a date is today
    func isToday(date: Date) -> Bool {
        return calendar.isDateInToday(date)
    }
    
    // Helper function to generate a week’s days from a given date
    func generateDaysForWeek(for date: Date) -> [Date] {
        var days = [Date]()
        let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: date)!.start

        for i in 0..<7 {
            if let day = calendar.date(byAdding: .day, value: i, to: startOfWeek) {
                days.append(day)
            }
        }
        
        return days
    }
}
