//  Learner
//
//  Created by Jwan Faisal Alameer
import SwiftUI

struct homeScreen: View {
    var language: String
    @State private var streak = 0
    @State private var freezesUsed = 0
    @State private var maxFreezes = 6
    @State private var todayLearned = false
    @State private var FrezzLearned = false
    @State private var previousStreak = 0
    @State private var previousFreezesUsed = 0
    @State private var selectedDate = Date()
    @State private var circleColor = Color.clear
    
    var body: some View {
        NavigationView {
            ZStack{
                Color.black.edgesIgnoringSafeArea(.all)
                
                VStack{
                    Text("\(formattedDate())")
                        .foregroundColor(Color.gray)
                    
                        .fontWeight(.regular)
                        .padding(.leading , -180)
                        .padding(.top , -355)
                }
                
                
                VStack{
                    Text("Learning \(language)")
                        .foregroundColor(Color.white)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.leading , -180)
                        .padding(.top , -330)
                }
                
                NavigationLink(destination: UpdateView()) { // View
                    Image(.streak)
                        .resizable()
                        .frame(width: 70, height: 70)
                        .padding(.leading, 300)
                        .padding(.bottom, 610)
                }
                VStack {
                    //display monthe and years
                    HStack {
                        Text(monthYearString(for: selectedDate))
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Button(action: {
                            // next monthe
                            selectedDate = Calendar.current.date(byAdding: .month, value: 1, to: selectedDate)!
                        }) {
                            Image(systemName: "chevron.right")
                                .foregroundColor(.orange)
                        }
                        .padding(.leading, -200)
                        
                        
                        
                        
                        HStack {
                            Button(action: {
                                // pervious week
                                selectedDate = Calendar.current.date(byAdding: .day, value: -7, to: selectedDate)!
                            }) {
                                Image(systemName: "chevron.left")
                                    .foregroundColor(.orange)
                            }
                            
                            Button(action: {
                                // next week
                                selectedDate = Calendar.current.date(byAdding: .day, value: 7, to: selectedDate)!
                            }) {
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.orange)
                            }
                        }
                    }
                    .padding()
                    
                    HStack(spacing: 20) {
                        ForEach(0..<7) { day in
                            VStack {
                                Text(getDayOfWeek(day: day))
                                    .foregroundColor(.gray)
                                
                            }
                        }
                        
                    }
                    
                    
                    
                    //display days of week
                    let daysOfWeek = generateDaysForWeek(for: selectedDate)
                    let columns = Array(repeating: GridItem(.flexible()), count: 7)
                    
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(daysOfWeek, id: \.self) { day in
                            VStack {
                                Text(dayFormatter.string(from: day))
                                
                                    .frame(width: 40, height: 40)
                                    .background(isToday(date: day) ? circleColor : Color.clear)
                                
                                    .cornerRadius(50)
                                    .foregroundColor(isFuture(date: day) ? Color.gray : Color.white)
                                    .onTapGesture {
                                        if !isFuture(date: day) {
                                            selectedDate = day
                                        }
                                    }
                            }
                            .disabled(isFuture(date: day))
                        }
                    }
                    Rectangle()
                        .frame(width: 380, height: 1)
                    
                    //.frame(height: 1)
                        .foregroundColor(.gray)
                    
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("   🔥 \(streak)")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.orange)
                            Text("Day streak")
                                .foregroundColor(.gray)
                            
                        } .padding(.trailing ,40)
                        
                        
                        Rectangle()
                            .frame(width: 1, height: 65)
                            .foregroundColor(.gray)
                            .padding(.horizontal, 10)
                        
                        VStack(alignment: .leading) {
                            Text("    ❄️\(freezesUsed) ")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                            
                            Text("Day freezed")
                                .foregroundColor(.gray)
                        }.padding(.leading ,10)
                            .padding()
                    }.padding(.leading ,20)
                    
                    
                }
                
                .background(Color.black)
                .overlay(                     RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white, lineWidth: 1)
                                              
                )
                .cornerRadius(20)
                .padding(.top , -260)
                
                
                // for counter in say streak and day freezed
                
                
                // for log today
                VStack{
                    Button(action: {
                        if FrezzLearned {
                            FrezzLearned = false
                            todayLearned = false
                            circleColor = Color.clear
                            freezesUsed = previousFreezesUsed
                            
                            
                        } else {
                            todayLearned.toggle()
                            if todayLearned {
                                circleColor = Color.orange.opacity(0.4)
                                streak += 1
                            }else{
                                streak = previousStreak
                                circleColor = Color.clear
                                
                                
                            }
                            
                        }
                    }) {
                        Text(todayLearned ? "Learned Today" : "Log today as Learned")
                            .font(.title2)
                            .bold()
                            .frame(width: 250, height: 250)
                            .background(todayLearned ? Color.orange.opacity(0.4):(FrezzLearned ? Color.blue.opacity(0.4):Color.orange))
                        
                            .cornerRadius(125)
                            .foregroundColor(todayLearned ? Color.orange : Color.black)
                        
                    }
                    .padding(.top, 290)
                }
                
                VStack{
                    Button(action: {
                        if !todayLearned {
                            FrezzLearned = true
                            if freezesUsed < maxFreezes {
                                freezesUsed += 1
                                circleColor = Color.blue.opacity(0.4)
                                
                            }
                            
                        }
                    }) {
                        Text("Freeze day")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 150, height: 50)
                            .background(todayLearned  || FrezzLearned ? Color.gray : Color.blue )
                        
                        .cornerRadius(10)}
                    
                    .disabled(todayLearned || FrezzLearned)
                    
                    
                    Text("\(freezesUsed) out of \(maxFreezes) freezes used")
                        .foregroundColor(.gray)
                    
                }.padding(.top, 660)
                
                
                
                
                
                
            }}
        .navigationBarBackButtonHidden(true)
        
    }
    //function
    
    func generateDaysForWeek(for date: Date) -> [Date] {
        var days = [Date]()
        let calendar = Calendar.current
        let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: date)!.start

// days in the bigging week
        
        for i in 0..<7 {
            if let day = calendar.date(byAdding: .day, value: i, to: startOfWeek) {
                days.append(day)
            }
        }
        
        return days
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
    
    func isSameDay(date1: Date, date2: Date) -> Bool {
        return Calendar.current.isDate(date1, inSameDayAs: date2)
    }
    
    func isFuture(date: Date) -> Bool {
        return date > Date()
    }
    
    var dayFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }
    
    func isToday(date: Date) -> Bool {
        return Calendar.current.isDateInToday(date)
    }


    func getDayOfWeek(day: Int) -> String {
        let daysOfWeek = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
        return daysOfWeek[day % 7]
    }

    
    
    
}
    


#Preview {
    homeScreen(language: "")
}
