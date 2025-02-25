//
//  DropdownMenuView.swift
//
//
//  Created by Corptia 02 on 17/09/2023.
//

import SwiftUI

public struct DropdownMenuView<Label:View>: View {
    @Binding var selectedOption: String
    var options: [String]
    var label : (Binding<String>)->Label
    
    public init(
        selectedOption : Binding<String>,
        options:[String],
        label : @escaping (Binding<String>)->Label
    ) {
        self.options = options
        self._selectedOption = selectedOption
        self.label = label
    }
    
    public var body: some View {
        if (!options.isEmpty) {
            Menu {
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        selectedOption = option
                    }) {
                        Text(option)
                    }
                }
            } label: {
                label($selectedOption)
            }
        } else {
            label($selectedOption)
        }
    }
    
}
