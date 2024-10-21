//
//  TimePicker.swift
//  MSViews
//
//  Created by Moha on 10/21/24.
//

import SwiftUI

public struct TimePicker<Content:View>: View {
    @State private var oldDate : Date = .init()
    @Binding public var date : Date
    public var hasCloseButton : Bool = false
    public var content : Content
    
    public init(
        date: Binding<Date>
        , hasCloseButton : Bool = false
        , minDate : (years:Int? , months:Int? , days:Int?)? = nil
        , maxDate : (years:Int? , months:Int? , days:Int?)? = nil
        ,@ViewBuilder content: ()->Content) {
            self._date = date
            self.oldDate = date.wrappedValue
            self.hasCloseButton = hasCloseButton
            self.content = content()
            self.minDate = minDate
            self.maxDate = maxDate
        }
    
    @State private var showCalendar : Bool = false
    var maxDate : (years:Int? , months:Int? , days:Int?)?
    var minDate : (years:Int?  , months:Int? , days:Int?)?
    
    public var body: some View {
        content
            .onTapGesture {
                withAnimation {
                    showCalendar.toggle()
                }
            }
            .fullScreenCover(isPresented: $showCalendar) {
                VStack(spacing: 15) {
                    HStack {
                        Spacer()
                        DatePicker(
                            selection: $date ,
                            in: minimumDate()...maximumDate() ,
                            displayedComponents: [.hourAndMinute]
                        ) {
                            
                        }
                        .tint(msViews.viewsHelper.mainAppColor)
                        .datePickerStyle(.wheel)
                        .frame(width: 250)
                        Spacer()
                    }
                    LoadingButton(
                        myState: .constant(.Enabled)
                        , height: msViews.margins.mainButtonHeight
                        , isInverted: false
                        , buttonText: strings("pick_time")
                        , fontWeight: .medium
                        , radius: 10
                    ) {
                        showCalendar = false
                    }
                    .padding(.horizontal , msViews.margins.mainMarginHorizontal)
                    
                    if(hasCloseButton) {
                        LoadingButton(
                            myState: .constant(.Enabled)
                            , height: msViews.margins.mainButtonHeight
                            , isInverted: true
                            , buttonText: strings("cancel")
                            , fontWeight: .medium
                            , radius: 10
                            , onClicked: {
                                self.date = self.oldDate
                                showCalendar = false
                            }
                        )
                        .padding(.horizontal , msViews.margins.mainMarginHorizontal)
                    }
                    
                }
            }
    }
    
    func getIntervals()->(minDateInterval : TimeInterval , maxDateInterval : TimeInterval){
        let a_day = (60) * (60) * (24)
        
        var maxDateInterval = 0.0
        var minDateInterval = 0.0
        
        if let maxDate {
            if let maxYears = maxDate.years {
                maxDateInterval = 1.0 * Double(a_day) * 365.25 * Double(maxYears)
            } else {
                if let maxMonths = maxDate.months {
                    maxDateInterval = 1.0 * Double(a_day) * 30.0 * Double(maxMonths)
                } else {
                    if let maxDays = maxDate.days {
                        maxDateInterval = 1.0 * Double(a_day) * Double(maxDays)
                    }
                }
            }
            
        }
        
        if let minDate {
            if let minYears = minDate.years {
                minDateInterval = -1.0 * Double(a_day) * 365.25 * Double(minYears)
            } else {
                if let minMonths = minDate.months {
                    minDateInterval = -1.0 * Double(a_day) * 30 * Double(minMonths)
                } else {
                    if let minDays = minDate.days {
                        minDateInterval = -1.0 * Double(a_day) * Double(minDays)
                    }
                }
            }
        }
        
        return (TimeInterval(minDateInterval) , TimeInterval(maxDateInterval))
    }
    
    func minimumDate()->Date {
        return Date.now.addingTimeInterval(getIntervals().minDateInterval)
    }
    
    func maximumDate()->Date {
        return Date.now.addingTimeInterval(getIntervals().maxDateInterval)
    }
    
}

struct TimePickerPreviewHelper : View {
    @State var date = Date()
    var body: some View {
        TimePicker(
            date: $date
            ,minDate: (years: 1, months: 0, days: 0)
            ,maxDate: (years: 1, months: 0, days: 0)
        ) {
            Text("\(date)")
        }
    }
}

struct TimePicker_Previews: PreviewProvider {
    static var previews: some View {
        TimePickerPreviewHelper()
    }
}
