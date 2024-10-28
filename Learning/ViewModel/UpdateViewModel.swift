//
//  UpdateViewModel.swift
//  Learning
//
//  Created by Jwan Faisal Alameer on 25/04/1446 AH.
//

import SwiftUI

class UpdateViewModel: ObservableObject {
    @Published var learningGoal: LearningGoalModel
    
    init() {
        self.learningGoal = LearningGoalModel(learning: "", selectedOption: "Month")
    }
    
    func updateLearningGoal(_ newLearning: String) {
        learningGoal.learning = newLearning
    }
    
    func updateSelectedOption(_ option: String) {
        learningGoal.selectedOption = option
    }
}
