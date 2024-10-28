// HomeModel.swift
import Foundation
import SwiftUI

struct HomeModel {
    var streak: Int = 0
    var freezesUsed: Int = 0
    var maxFreezes: Int = 6
    var todayLearned: Bool = false
    var freezeLearned: Bool = false
    var previousStreak: Int = 0
    var previousFreezesUsed: Int = 0
}
