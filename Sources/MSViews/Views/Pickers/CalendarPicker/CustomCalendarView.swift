//
//  CustomCalendarView.swift
//  MyTestProject
//
//  Created by Moha on 1/12/26.
//

import SwiftUI

public struct CustomCalendarView : View {
    
    public init(
        selection: Binding<Date?>,
        style: CalendarStyle = .init(),
        showTodayButton: Bool = true,
        firstWeekday: Weekday = .sunday,
        minDate: Date? = nil,
        maxDate: Date? = nil
    ) {
        self._selection = selection
        self.style = style
        self.showTodayButton = showTodayButton
        self.firstWeekday = firstWeekday
        self.minDate = minDate
        self.maxDate = maxDate
    }
    
    @Binding var selection: Date?
    var style: CalendarStyle = CalendarStyle()
    
    var showTodayButton: Bool = true
    var firstWeekday: Weekday = .sunday
    
    var minDate: Date? = nil
    var maxDate: Date? = nil
    
    @State var currentDay : Int = 0
    @State var currentDayOfTheWeek : String = ""
    @State var currentMonth : String = ""
    @State private var currentDate: Date = Date()
    @State private var slideDirection: CGFloat = 0
    
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    public var body: some View {
        VStack {
            calendarView
                .onAppear {
                    updateCalendar()
                }
            Spacer()
        }
    }
    
    var calendarView : some View {
        return VStack(spacing: 16) {
            HStack {
                Button {
                    if let minDate = minDate {
                        let prevMonth = Calendar.current.date(byAdding: .month, value: -1, to: currentDate)!
                        let startOfPrevMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: prevMonth))!
                        let startOfMinMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: minDate))!
                        if startOfPrevMonth < startOfMinMonth {
                            return
                        }
                    }
                    slideDirection = -1
                    withAnimation(.easeInOut(duration: 0.25)) {
                        currentDate = Calendar.current.date(byAdding: .month, value: -1, to: currentDate)!
                        updateCalendar()
                    }
                } label: {
                    Image(systemName: "chevron.left")
                }

                Spacer()

                Text(currentMonth)
                    .font(.title)
                    .bold()

                Spacer()

                Button {
                    if let maxDate = maxDate {
                        let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: currentDate)!
                        let startOfNextMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: nextMonth))!
                        if startOfNextMonth > maxDate {
                            return
                        }
                    }
                    slideDirection = 1
                    withAnimation(.easeInOut(duration: 0.25)) {
                        currentDate = Calendar.current.date(byAdding: .month, value: 1, to: currentDate)!
                        updateCalendar()
                    }
                } label: {
                    Image(systemName: "chevron.right")
                }
            }

            weekDays
            
            theDaysGrid
            
            todayButton
        }
        .gesture(
            gesture
        )
        .padding()
    }

    var gesture: _EndedGesture<DragGesture> {
        DragGesture()
            .onEnded { value in
                if value.translation.width < -50 {
                    if let maxDate = maxDate {
                        let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: currentDate)!
                        let startOfNextMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: nextMonth))!
                        if startOfNextMonth > maxDate {
                            return
                        }
                    }
                    slideDirection = 1
                    withAnimation(.easeInOut(duration: 0.25)) {
                        currentDate = Calendar.current.date(byAdding: .month, value: 1, to: currentDate)!
                        updateCalendar()
                    }
                } else if value.translation.width > 50 {
                    if let minDate = minDate {
                        let prevMonth = Calendar.current.date(byAdding: .month, value: -1, to: currentDate)!
                        let startOfPrevMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: prevMonth))!
                        let startOfMinMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: minDate))!
                        if startOfPrevMonth < startOfMinMonth {
                            return
                        }
                    }
                    slideDirection = -1
                    withAnimation(.easeInOut(duration: 0.25)) {
                        currentDate = Calendar.current.date(byAdding: .month, value: -1, to: currentDate)!
                        updateCalendar()
                    }
                }
            }
    }
    
    func generateDays() -> [(day: Int, isCurrentMonth: Bool)] {
        let calendar = Calendar.current
        let date = currentDate

        // Current month info
        let currentRange = calendar.range(of: .day, in: .month, for: date)!
        let daysInCurrentMonth = currentRange.count

        let firstOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: date))!
        var firstWeekdayOfMonth = calendar.component(.weekday, from: firstOfMonth)
        firstWeekdayOfMonth = (firstWeekdayOfMonth - firstWeekday.rawValue + 7) % 7

        // Previous month info
        let previousMonth = calendar.date(byAdding: .month, value: -1, to: date)!
        let prevRange = calendar.range(of: .day, in: .month, for: previousMonth)!
        let daysInPreviousMonth = prevRange.count

        var result: [(Int, Bool)] = []

        // 1️⃣ Previous month days
        if firstWeekdayOfMonth > 0 {
            for day in (daysInPreviousMonth - firstWeekdayOfMonth + 1)...daysInPreviousMonth {
                result.append((day, false))
            }
        }

        // 2️⃣ Current month days
        for day in 1...daysInCurrentMonth {
            result.append((day, true))
        }

        // 3️⃣ Next month days
        let remaining = 42 - result.count
        if remaining > 0 {
            for day in 1...remaining {
                result.append((day, false))
            }
        }

        return result
    }
    
    func updateCalendar() {
        let calendar = Calendar.current
        currentDay = calendar.component(.day, from: currentDate)

        currentMonth = DateFormatter().monthSymbols[
            calendar.component(.month, from: currentDate) - 1
        ]
    }
    
    func isToday(day: Int) -> Bool {
        let calendar = Calendar.current
        let today = Date()

        return calendar.component(.day, from: today) == day &&
               calendar.component(.month, from: today) == calendar.component(.month, from: currentDate) &&
               calendar.component(.year, from: today) == calendar.component(.year, from: currentDate)
    }
    
    var weekDays : some View {
        let weekEnums: [Weekday] = [.sunday, .monday, .tuesday, .wednesday, .thursday, .friday, .saturday]
        let startIndex = weekEnums.firstIndex(where: { $0.rawValue == firstWeekday.rawValue }) ?? 0
        let rotatedWeek = Array(weekEnums[startIndex...] + weekEnums[..<startIndex])
        return LazyVGrid(columns: columns) {
            ForEach(rotatedWeek, id: \.self) { day in
                Text(day.shortName)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
    
    fileprivate func onDateChange(_ item: (day: Int, isCurrentMonth: Bool)) {
        var selectedComponents = Calendar.current.dateComponents([.year, .month], from: currentDate)
        selectedComponents.day = item.day
        if let selectedDate = Calendar.current.date(from: selectedComponents) {
            selection = selectedDate
        }
    }
    
    fileprivate func dayBackgroundColor(_ item: (day: Int, isCurrentMonth: Bool)) -> Color {
        let calendar = Calendar.current
        var dayDateComponents = calendar.dateComponents([.year, .month], from: currentDate)
        dayDateComponents.day = item.day
        guard let dayDate = calendar.date(from: dayDateComponents) else { return Color.clear }

        // Disable background if outside range
        if let minDate = minDate, dayDate < minDate { return Color.clear }
        if let maxDate = maxDate, dayDate > maxDate { return Color.clear }

        // Selected day
        if item.isCurrentMonth,
           let selected = selection,
           calendar.isDate(selected, inSameDayAs: dayDate) {
            return style.selectedBackground
        }

        // Today
        if item.isCurrentMonth, isToday(day: item.day) {
            return style.todayBackground.opacity(selection != nil ? style.todayOpacityWhenNotSelected : 1)
        }

        return Color.clear
    }
    
    fileprivate func dayTextColor(_ item: (day: Int, isCurrentMonth: Bool)) -> Color {
        let calendar = Calendar.current
        var dayDateComponents = calendar.dateComponents([.year, .month], from: currentDate)
        dayDateComponents.day = item.day
        guard let dayDate = calendar.date(from: dayDateComponents) else { return .gray }

        // Outside min/max range
        if let minDate = minDate, dayDate < minDate { return .gray }
        if let maxDate = maxDate, dayDate > maxDate { return .gray }

        if item.isCurrentMonth {
            if let selected = selection, calendar.isDate(selected, inSameDayAs: dayDate) {
                return style.selectedText
            } else if isToday(day: item.day) {
                return style.selectedText
            } else {
                return style.currentMonthText
            }
        } else {
            return style.otherMonthText
        }
    }
    
    var theDaysGrid : some View {
        let allDays = generateDays()
        let weeks = stride(from: 0, to: allDays.count, by: 7).map { Array(allDays[$0..<$0+7]) }
        
        return VStack(spacing: 12) {
            ForEach(0..<weeks.count, id: \.self) { weekIndex in
                let week = weeks[weekIndex]
                // Only show weeks that contain at least one current month day
                if week.contains(where: { $0.isCurrentMonth }) {
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(Array(week.enumerated()), id: \.offset) { _, item in
                            Text("\(item.day)")
                                .frame(width: style.daySize, height: style.daySize)
                                .background(
                                    dayBackgroundColor(item)
                                )
                                .foregroundColor(
                                    dayTextColor(item)
                                )
                                .clipShape(RoundedRectangle(cornerRadius: style.circleCornerRadius))
                                .font(style.font)
                                .onTapGesture {
                                    if item.isCurrentMonth {
                                        onDateChange(item)
                                    }
                                }
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    var todayButton : some View {
        if showTodayButton && (selection == nil || !Calendar.current.isDate(selection!, inSameDayAs: Date())) {
            Button {
                slideDirection = 0
                withAnimation(.easeInOut(duration: 0.25)) {
                    currentDate = Date()
                    selection = Date()
                    updateCalendar()
                }
            } label: {
                Text("Today")
                    .font(.caption)
                    .padding(6)
                    .background(style.todayBackground.opacity(0.2))
                    .cornerRadius(6)
            }
            .padding(.top, 4)
        }
    }
}

#Preview {
    CustomCalendarView(
        selection: .constant(Date()),
        showTodayButton: true,
        firstWeekday: .saturday,
        minDate: Date().addingTimeInterval(-28 * 24 * 60 * 60),
        maxDate: Date().addingTimeInterval(2 * 30 * 24 * 60 * 60)
    )
}

public enum Weekday: Int {
    case sunday = 1
    case monday = 2
    case tuesday = 3
    case wednesday = 4
    case thursday = 5
    case friday = 6
    case saturday = 7

    var shortName: String {
        switch self {
        case .sunday: return "Sun"
        case .monday: return "Mon"
        case .tuesday: return "Tue"
        case .wednesday: return "Wed"
        case .thursday: return "Thu"
        case .friday: return "Fri"
        case .saturday: return "Sat"
        }
    }
}

public struct CalendarStyle {
    var todayBackground: Color = .blue
    var todayOpacityWhenNotSelected: Double = 0.5
    var selectedBackground: Color = .blue
    var selectedText: Color = .white
    var currentMonthText: Color = .primary
    var otherMonthText: Color = .gray
    var daySize: CGFloat = 40
    var circleCornerRadius: CGFloat = 20
    var font: Font = .body
    
    public init(
        todayBackground: Color = .blue,
        todayOpacityWhenNotSelected: Double = 0.5,
        selectedBackground: Color = .blue,
        selectedText: Color = .white,
        currentMonthText: Color = .primary,
        otherMonthText: Color = .gray,
        daySize: CGFloat = 40,
        circleCornerRadius: CGFloat = 20,
        font: Font = .body
    ) {
        self.todayBackground = todayBackground
        self.todayOpacityWhenNotSelected = todayOpacityWhenNotSelected
        self.selectedBackground = selectedBackground
        self.selectedText = selectedText
        self.currentMonthText = currentMonthText
        self.otherMonthText = otherMonthText
        self.daySize = daySize
        self.circleCornerRadius = circleCornerRadius
        self.font = font
    }
}
