//
//  SwiftUIView.swift
//  
//
//  Created by Corptia 02 on 15/08/2023.
//

import SwiftUI

public struct CalendarPicker<Content:View>: View {
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
                    DatePicker(
                        selection: $date ,
                        in: minimumDate()...maximumDate() ,
                        displayedComponents: [.date]
                    ) {
                        
                    }
                    .tint(msViews.viewsHelper.mainAppColor)
                    .datePickerStyle(.graphical)
                    
                    LoadingButton(
                        myState: .constant(.Enabled)
                        , height: msViews.margins.mainButtonHeight
                        , isInverted: false
                        , buttonText: strings("pick_date")
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

struct CalendarPickerPreviewHelper : View {
    @State var date = Date()
    var body: some View {
        CalendarPicker(
            date: $date
            ,minDate: (years: 1, months: 0, days: 0)
            ,maxDate: (years: 1, months: 0, days: 0)
        ) {
            Text("\(date)")
        }
    }
}

struct CalendarPicker_Previews: PreviewProvider {
    static var previews: some View {
        CalendarPickerPreviewHelper()
    }
}
