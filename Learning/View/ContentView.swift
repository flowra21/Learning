//
//  ContentView.swift
//  Learning
//
//  Created by Jwan Faisal Alameer on 25/04/1446 AH.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = LearnerViewModel() // ViewModel

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                Image(.streak)
                    .resizable()
                    .frame(width : 200 , height: 200)
                    .padding(.top , -350)
                
                VStack {
                    Text("Hello Learner!") // View
                        .foregroundColor(Color.white)
                        .font(.largeTitle)
                        .bold()
                        .padding(.leading , -140)
                        .padding(.top , -110)
                }
                
                VStack {
                    Text("This app will help you learn everyday")  // View
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.leading , -110)
                        .padding(.top , -60)
                }
                
                VStack {
                    Text("I want to learn ") // View
                        .foregroundColor(Color.white)
                        .bold()
                        .padding(.leading , -180)
                        .padding(.top , 70)
                    
                    TextField("Swift", text: $viewModel.learningModel.title) // استخدام Model
                        .foregroundColor(.gray)
                        .accentColor(.orange)
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.gray).opacity(0.5), alignment: .bottom
                        )
                        .padding(.horizontal, 20)
                }
                
                VStack {
                    Text("I want to learn it in a") // View
                        .foregroundColor(Color.white)
                        .bold()
                        .padding(.leading , -180)
                        .padding(.top , 180)
                }
                
                HStack {
                    Button(action: {
                        viewModel.updateLearningOption(option: "Week") // ViewModel
                    }) {
                        Text("Week") // View
                            .fontWeight(viewModel.learningModel.selectedOption == "Week" ? .bold : .regular) // استخدام Model
                            .frame(width: 50, height: 10)
                            .foregroundColor(viewModel.learningModel.selectedOption == "Week" ? Color.black : Color.orange)
                            .padding()
                            .background(viewModel.learningModel.selectedOption == "Week" ? Color.orange : Color.gray.opacity(0.4))
                            .cornerRadius(10)
                    }
                    .padding(.top, 270)
                    .padding(.leading, -90)
                    
                    Button(action: {
                        viewModel.updateLearningOption(option: "Month") // ViewModel
                    }) {
                        Text("Month") // View
                            .fontWeight(viewModel.learningModel.selectedOption == "Month" ? .bold : .regular) // استخدام Model
                            .frame(width: 60, height: 10)
                            .foregroundColor(viewModel.learningModel.selectedOption == "Month" ? Color.black : Color.orange)
                            .padding()
                            .background(viewModel.learningModel.selectedOption == "Month" ? Color.orange : Color.gray.opacity(0.4))
                            .cornerRadius(10)
                    }
                    .padding(.top, 270)
                    
                    Button(action: {
                        viewModel.updateLearningOption(option: "Year") // ViewModel
                    }) {
                        Text("Year") // View
                            .fontWeight(viewModel.learningModel.selectedOption == "Year" ? .bold : .regular) // استخدام Model
                            .frame(width: 50, height: 10)
                            .foregroundColor(viewModel.learningModel.selectedOption == "Year" ? Color.black : Color.orange)
                            .padding()
                            .background(viewModel.learningModel.selectedOption == "Year" ? Color.orange : Color.gray.opacity(0.4))
                            .cornerRadius(10)
                    }
                    .padding(.top, 270)
                    .padding(.leading, 6)
                }
                
                Button(action: {
                    viewModel.startLearning() // ViewModel
                }) {
                    HStack {
                        Text("Start") // View
                        Image(systemName: "arrow.right") // View
                            .foregroundColor(.black)
                    }
                    .foregroundColor(.black)
                    .bold()
                    .frame(width: 150, height: 50)
                    .background(Color.orange)
                    .cornerRadius(10)
                }
                .padding(.top, 450)
                .background(NavigationLink(destination: homeScreen(language: viewModel.learningModel.title), isActive: $viewModel.navigateToHome) { EmptyView() }) // View
            }
        }
    }
}




#Preview {
    ContentView()
}
