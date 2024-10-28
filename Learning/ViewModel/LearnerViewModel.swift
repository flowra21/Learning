//
//  LearnerViewModel.swift
//  Learning
//
//  Created by Jwan Faisal Alameer on 25/04/1446 AH.
//

import SwiftUI
import Combine

class LearnerViewModel: ObservableObject {
    
    //1
    @Published var learningModel: LearningModel
    @Published var navigateToHome: Bool = false // التحكم في التنقل
    
    init() {
        self.learningModel = LearningModel(title: "", selectedOption: "Month")
    }
    
    func updateLearningOption(option: String) {
        learningModel.selectedOption = option
    }
    
    func startLearning() {
        navigateToHome = true
    }
    //2
}
