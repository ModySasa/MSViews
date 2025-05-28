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
    var checkBox : CheckBox
    
    var label: (Binding<[String]>) -> Label
    
    @State private var isPopoverPresented = false

    public init(
        selectedOptions: Binding<[String]> ,
        options: [String] ,
        isPopoverPresented: Bool = false ,
        checkBox : CheckBox ,
        saveText: String ,
        label: @escaping (Binding<[String]>) -> Label
    ) {
        self._selectedOptions = selectedOptions
        self.options = options
        self.label = label
        self.isPopoverPresented = isPopoverPresented
        self.checkBox = checkBox
        self.saveText = saveText
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
                        checkBox
                    }
                    Divider()
                    Text(
                        saveText
                    ).onTapGesture {
                        isPopoverPresented = false
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                }
                .padding()
                .frame(width: 250)
            }
        }
    }
}
