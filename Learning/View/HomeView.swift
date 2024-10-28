// homeScreen.swift
import SwiftUI

struct HomeView: View {
    var language: String
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("\(formattedDate())")
                        .foregroundColor(Color.gray)
                        .fontWeight(.regular)
                        .padding(.leading, -180)
                        .padding(.top, -355)
                    
                    Text("Learning \(language)")
                        .foregroundColor(Color.white)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.leading, -180)
                        .padding(.top, -330)
                }
                
                NavigationLink(destination: UpdateView()) {
                    Image(.streak)
                        .resizable()
                        .frame(width: 70, height: 70)
                        .padding(.leading, 300)
                        .padding(.bottom, 610)
                }
                
                VStack {
                    HStack {
                        Text(monthYearString(for: viewModel.selectedDate))
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Button(action: {
                            viewModel.selectedDate = Calendar.current.date(byAdding: .month, value: 1, to: viewModel.selectedDate)!
                        }) {
                            Image(systemName: "chevron.right")
                                .foregroundColor(.orange)
                        }
                        .padding(.leading, -200)
                        
                        HStack {
                            Button(action: {
                                viewModel.selectedDate = Calendar.current.date(byAdding: .day, value: -7, to: viewModel.selectedDate)!
                            }) {
                                Image(systemName: "chevron.left")
                                    .foregroundColor(.orange)
                            }
                            
                            Button(action: {
                                viewModel.selectedDate = Calendar.current.date(byAdding: .day, value: 7, to: viewModel.selectedDate)!
                            }) {
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.orange)
                            }
                        }
                    }
                    .padding()
                    
                    let daysOfWeek = viewModel.generateDaysForWeek(for: viewModel.selectedDate)
                    let columns = Array(repeating: GridItem(.flexible()), count: 7)
                    
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(daysOfWeek, id: \.self) { day in
                            VStack {
                                Text(dayFormatter.string(from: day))
                                    .frame(width: 40, height: 40)
                                    .background(viewModel.isToday(date: day) ? viewModel.circleColor : Color.clear)
                                    .cornerRadius(50)
                                    .foregroundColor(viewModel.isFuture(date: day) ? Color.gray : Color.white)
                                    .onTapGesture {
                                        if !viewModel.isFuture(date: day) {
                                            viewModel.selectedDate = day
                                        }
                                    }
                            }
                            .disabled(viewModel.isFuture(date: day))
                        }
                    }
                    
                    Rectangle()
                        .frame(width: 380, height: 1)
                        .foregroundColor(.gray)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("   🔥 \(viewModel.homeModel.streak)")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.orange)
                            Text("Day streak")
                                .foregroundColor(.gray)
                        }.padding(.trailing, 40)
                        
                        Rectangle()
                            .frame(width: 1, height: 65)
                            .foregroundColor(.gray)
                            .padding(.horizontal, 10)
                        
                        VStack(alignment: .leading) {
                            Text("    ❄️ \(viewModel.homeModel.freezesUsed)")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                            Text("Day frozen")
                                .foregroundColor(.gray)
                        }.padding(.leading, 10)
                        .padding()
                    }.padding(.leading, 20)
                }
                .background(Color.black)
                .overlay(RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white, lineWidth: 1))
                .cornerRadius(20)
                .padding(.top, -260)
                
                VStack {
                    Button(action: {
                        if viewModel.homeModel.freezeLearned {
                            viewModel.resetFreeze()
                        } else {
                            viewModel.logTodayAsLearned()
                        }
                    }) {
                        Text(viewModel.homeModel.todayLearned ? "Learned Today" : "Log today as Learned")
                            .font(.title2)
                            .bold()
                            .frame(width: 250, height: 250)
                            .background(viewModel.homeModel.todayLearned ? Color.orange.opacity(0.4) : (viewModel.homeModel.freezeLearned ? Color.blue.opacity(0.4) : Color.orange))
                            .cornerRadius(125)
                            .foregroundColor(viewModel.homeModel.todayLearned ? Color.orange : Color.black)
                    }
                    .padding(.top, 290)
                }
                
                VStack {
                    Button(action: {
                        viewModel.freezeDay()
                    }) {
                        Text("Freeze day")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 150, height: 50)
                            .background(viewModel.homeModel.todayLearned || viewModel.homeModel.freezeLearned ? Color.gray : Color.blue)
                            .cornerRadius(10)
                    }
                    .disabled(viewModel.homeModel.todayLearned || viewModel.homeModel.freezeLearned)
                    
                    Text("\(viewModel.homeModel.freezesUsed) out of \(viewModel.homeModel.maxFreezes) freezes used")
                        .foregroundColor(.gray)
                }.padding(.top, 660)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMM"
        return formatter.string(from: Date())
    }

    func monthYearString(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }

    var dayFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }
}

#Preview {
    HomeView(language: "English")
}
