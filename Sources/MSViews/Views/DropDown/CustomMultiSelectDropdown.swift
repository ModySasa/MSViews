//
//  CustomMultiSelectDropdown.swift
//  MSViews
//
//  Created by Moha on 5/28/25.
//

import SwiftUI

public struct CustomMultiSelectDropdown<Label: View>: View {
    @Binding var selectedOptions: [String]
    var options: [String]
    let saveText: String
    
    let isChechBoxRound : Bool
    let isCheckBoxFilled : Bool
    
    let checkTextColor : Color
    let checkedColor : Color
    let checkFillColor : Color
    let unCheckedColor : Color
     
    let checkTextSize : Double
    
    let checkTextWeight : Font.Weight
    
    
    var label: (Binding<[String]>) -> Label
    
    @State private var isPopoverPresented = false

    public init(
        selectedOptions: Binding<[String]>,
        options: [String],
        saveText: String,
        isChechBoxRound: Bool,
        isCheckBoxFilled: Bool,
        checkTextColor: Color,
        checkedColor: Color,
        checkFillColor: Color,
        unCheckedColor: Color,
        checkTextSize: Double,
        checkTextWeight: Font.Weight,
        label: @escaping (Binding<[String]>) -> Label,
    ) {
        self._selectedOptions = selectedOptions
        self.options = options
        self.saveText = saveText
        self.isChechBoxRound = isChechBoxRound
        self.isCheckBoxFilled = isCheckBoxFilled
        self.checkTextColor = checkTextColor
        self.checkedColor = checkedColor
        self.checkFillColor = checkFillColor
        self.unCheckedColor = unCheckedColor
        self.checkTextSize = checkTextSize
        self.checkTextWeight = checkTextWeight
        self.label = label
    }
        
    public var body: some View {
        Button(action: {
            isPopoverPresented.toggle()
        }) {
            label($selectedOptions)
        }
        .popover(isPresented: $isPopoverPresented, arrowEdge: .bottom) {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(options, id: \.self) { option in
                        CheckBox(
                            isChecked: .init(get: {
                                let isIn = selectedOptions.contains(option)
                                print(isIn)
                                return isIn
                            }, set: { b in
                                if(b ?? false) {
                                    selectedOptions.append(option)
                                } else {
                                    selectedOptions.removeAll { s in
                                        s == option
                                    }
                                }
                            }),
                            text: option,
                            isRound: isChechBoxRound,
                            isFilled: isCheckBoxFilled,
                            textColor: checkTextColor,
                            textSize: checkTextSize,
                            textWeight: checkTextWeight,
                            checkedColor: checkedColor,
                            fillColor: checkFillColor,
                            unCheckedColor: unCheckedColor
                        )
                    }
                    Divider()
                    Text(
                        saveText
                    )
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    .onTapGesture {
                        isPopoverPresented = false
                    }
                }
                .padding()
                .frame(width: 250)
            }
        }
    }
}
