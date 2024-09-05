//
//  SwiftUIView.swift
//
//
//  Created by Corptia 02 on 12/08/2023.
//

import SwiftUI

public struct FieldWithTitle: View {
    @Binding public var title : String
    @Binding public var txt : String
    @Binding public var isSecured : Bool
    @Binding public var errorText : String
    
    public var placeHolder : String = ""
    public var isPassword : Bool = false
    public var disabled : Bool = false
    public var type : UIKeyboardType = .default
    public var submitLabel : SubmitLabel = .next
    
    public init(
        title: Binding<String>
        , txt: Binding<String>
        , isSecured: Binding<Bool>
        , errorText: Binding<String>
        , placeHolder: String = ""
        , isPassword: Bool = false
        , disabled: Bool = false
        , type: UIKeyboardType = .default
        , submitLabel: SubmitLabel = .next
    ) {
        self._title = title
        self._txt = txt
        self._isSecured = isSecured
        self._errorText = errorText
        self.placeHolder = placeHolder
        self.isPassword = isPassword
        self.disabled = disabled
        self.type = type
        self.submitLabel = submitLabel
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 9) {
            Text(title)
                .foregroundColor(msViews.viewsHelper.secondTextColor)
            OneLineField(
                txt: $txt
                , errorText: $errorText
                , placeHolder: placeHolder
                , isPassword: isPassword
                , disabled: disabled
                , type: type
                , submitLabel: submitLabel
                , padding: 15
                , radius: 10
                , textSize: 14
                , textWeight: .regular
                , onSubmit: { _ in}
                , onTextChange: { _ in}
            )
        }
    }
}

struct FieldWithTitle_Previews: PreviewProvider {
    static var previews: some View {
        FieldWithTitle(title: .constant("title"), txt: .constant("Test"), isSecured: .constant(true), errorText: .constant(""))
    }
}
