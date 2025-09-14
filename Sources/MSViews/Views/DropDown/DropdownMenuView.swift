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
    var onSelect: ((String)->Void)?
    
    public init(
        selectedOption : Binding<String>,
        options:[String],
        label : @escaping (Binding<String>)->Label,
        onSelect: ((String)->Void)? = nil
    ) {
        self.options = options
        self._selectedOption = selectedOption
        self.label = label
        self.onSelect = onSelect
    }
    
    public var body: some View {
        if (!options.isEmpty) {
            Menu {
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        selectedOption = option
                        if let onSelect = onSelect {
                            onSelect(selectedOption)
                        }
                    }) {
                        Text(LocalizedStringKey(option))
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
