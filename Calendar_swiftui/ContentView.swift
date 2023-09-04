//
//  ContentView.swift
//  Calendar_swiftui
//
//  Created by Carmen Lucas on 3/9/23.
//

import SwiftUI

struct ContentView: View {
    let days: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat" ]
    @State var selectedMonth = 0
    @State var selectedDate = Date()
    var body: some View {
        VStack {
            ZStack{
                Circle()
                    .foregroundStyle(.gray)
                    .opacity(0.5)
                Image(systemName: "calendar")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
            }.frame(width: 110)
            Text("Calendly course")
                .font(.title)
                .bold()
            
            Rectangle()
                .frame(height:1)
            VStack{
                Text("Select a Day")
                    .font(.title2)
                    .bold()
                
                HStack{
                    Spacer()
                    Button{
                        withAnimation {
                            selectedMonth -= 1
                        }
                    } label:{
                        Image(systemName: "lessthan")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 16, height: 28)
                            .foregroundStyle(.gray)
                    }
                    Spacer()
                    Text(selectedDate.monthAndYear())
                    Spacer()
                    Button{
                        withAnimation {
                            selectedMonth += 1
                        }
                    } label: {
                        Image(systemName: "greaterthan")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 16, height: 28)
                            .foregroundStyle(.gray)
                    }
                    Spacer()
                }
                HStack{
                    ForEach(days, id: \.self) { day in
                     
                        Text(day)
                            .font(.system(size: 16, weight: .medium))
                            .frame(maxWidth: .infinity)
                     
                    }
                }
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7),
                          spacing: 20){
                    ForEach(fetchDates()){ value in
                        ZStack{
                            if value.day != -1 {
                                Text("\(value.day)")
                            }
                            else{
                                Text("")
                            }
                        }.frame(width: 32, height: 32)
                    }
                }
            }
            .padding()
            .onChange(of: selectedMonth) {
                selectedDate = fetchSelectedMonth()
            }
        }
        
    }
    
    func fetchDates() -> [CalendarDate] {
        let calendar = Calendar.current
        let currentMonth = fetchSelectedMonth()
        
        var dates = currentMonth.datesOfMonth().map({CalendarDate(day: calendar.component(.day, from: $0), date: $0)})
        let firstDayOfWeek = calendar.component(.weekday, from: dates.first?.date ?? Date())
        
        for _ in 0..<firstDayOfWeek - 1 {
            dates.insert(CalendarDate(day: -1, date: Date()), at: 0)
        }
        return dates
        
    }
    
    func fetchSelectedMonth() -> Date {
        let calendar = Calendar.current
        
        let month = calendar.date(byAdding: .month,value: selectedMonth, to: Date())
        
        return month!
    }
}
extension Date {
    func monthAndYear() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM YYYY"
        
        return formatter.string(from: self)
    }
    func datesOfMonth() -> [Date] {
        let calendar = Calendar.current
        let currentMonth = calendar.component(.month, from: self)
        let currentYear = calendar.component(.year, from: self)
        
        var startDateComponents = DateComponents()
        startDateComponents.year = currentYear
        startDateComponents.month = currentMonth
        startDateComponents.day = 1
        let startDate = calendar.date(from: startDateComponents)!
        
        var endDateComponents = DateComponents()
        endDateComponents.month = 1
        endDateComponents.day = -1
        let endDate = calendar.date(byAdding: endDateComponents, to: startDate)!
        
        var dates: [Date] = []
        var currentDate = startDate
        
        while currentDate <= endDate {
            dates.append(currentDate)
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
        return dates
        
    }
}
struct CalendarDate: Identifiable {
    let id = UUID()
    var day: Int
    var date: Date
}
#Preview {
    ContentView()
}
