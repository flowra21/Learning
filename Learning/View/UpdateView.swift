//
//  UpdateView.swift
//  Learning
//
//  Created by Jwan Faisal Alameer on 25/04/1446 AH.
//

import SwiftUI

struct UpdateView: View {
    @StateObject private var viewModel = UpdateViewModel() // ViewModel
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack{ Text("Learning goal")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.top , -330)
            }
            
            
            VStack{
                Button(action: {
                    // Action for Update button
                }) {
                    Text("Update")
                        .fontWeight(.bold)
                        .foregroundColor(.orange)
                        
                }.padding(.top,-330)
                    .padding(.leading ,300)
                
            }
            VStack{
                Text("I want to learn")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.leading ,-180)
                
                TextField("Swift", text:     $viewModel.learningGoal.learning
)
                    .foregroundColor(.gray)
                    .accentColor(.orange)
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray).opacity(0.5),alignment: .bottom )
                    .padding(.horizontal, 20)
                
            } .padding(.top,-260)
            
            VStack{
                Text("I want to learn it in a")
                    .foregroundColor(Color.white)
                    .bold()
                    .padding(.leading , -180)
                    .padding(.top , -180)
                
            }
        
            
            HStack {
                Button(action: {
                    viewModel.updateSelectedOption("Week")
                }) {
                    Text("Week") // View
                        .fontWeight(viewModel.learningGoal.selectedOption == "Week" ? .bold : .regular)// استخدام Model
                        .frame(width: 50, height: 10)
                        .foregroundColor(viewModel.learningGoal.selectedOption == "Week" ? Color.black : Color.orange)
                        .padding()
                        .background(viewModel.learningGoal.selectedOption == "Week" ? Color.orange : Color.gray.opacity(0.4))
                        .cornerRadius(10)
                }
                .padding(.top, 270)
                .padding(.leading, -90)
                
                Button(action: {
                    viewModel.updateSelectedOption("Month")
                }) {
                    Text("Month") // View
                        .fontWeight(viewModel.learningGoal.selectedOption == "Month" ? .bold : .regular) // استخدام Model
                        .frame(width: 60, height: 10)
                        .foregroundColor(viewModel.learningGoal.selectedOption == "Month" ? Color.black : Color.orange)
                        .padding()
                        .background(viewModel.learningGoal.selectedOption == "Month" ? Color.orange : Color.gray.opacity(0.4))
                        .cornerRadius(10)
                }
                .padding(.top, 270)
                
                Button(action: {
                    viewModel.updateSelectedOption("Year")
                }) {
                    Text("Year") // View
                        .fontWeight(viewModel.learningGoal.selectedOption == "Year" ? .bold : .regular) // استخدام Model
                        .frame(width: 50, height: 10)
                        .foregroundColor(viewModel.learningGoal.selectedOption == "Year" ? Color.black : Color.orange)
                        .padding()
                        .background(viewModel.learningGoal.selectedOption == "Year" ? Color.orange : Color.gray.opacity(0.4))
                        .cornerRadius(10)
                }
                .padding(.top, 270)
                .padding(.leading, 6)
            }
            .padding(.top, -420)
                
            .padding(.leading, 30)
                .navigationTitle("Update")
            }
        }
    }


#Preview {
    UpdateView()
}
