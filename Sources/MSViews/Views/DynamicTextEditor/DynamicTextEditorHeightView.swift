//
//  DynamicTextEditorHeightView.swift
//  DeltaCapital
//
//  Created by Moha on 11/10/25.
//


import SwiftUI

public struct DynamicTextEditorHeightView: View {
    @Binding var text: String
    @State private var textHeight: CGFloat = 38
    @State private var textWidth: CGFloat = 38
    
    private let fontSize: CGFloat
    private let fontWeight: Font.Weight

    public init (
        text: Binding<String>,
        fontWeight: Font.Weight = .medium,
        fontSize: CGFloat = 14
    ) {
        self._text = text
        self.fontWeight = fontWeight
        self.fontSize = fontSize
    }
    
    public var body: some View {
        GeometryReader { geometry in
            TextEditor(text: $text)
                .onChange(of: text) { _ in
                    if let font = UIFont(name: getAppFont(fontWeight), size: fontSize) {
                        textWidth = geometry.size.width // match your .padding(4)
                        textHeight = text.heightForTextEditor(width: textWidth, font: font)
                    } else {
                        print("THERE IS NO FONT FROM THIS NAME")
                    }
                }
        }
        .frame(height: textHeight)
    }
}

extension String {
    func heightForTextEditor(width: CGFloat, font: UIFont) -> CGFloat {
        let text = self.isEmpty ? " " : self
        let constraintBox = CGSize(width: width - 8, height: .greatestFiniteMagnitude) // subtract padding
        let boundingBox = text.boundingRect(
            with: constraintBox,
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: [.font: font],
            context: nil
        )
        return ceil(boundingBox.height) + 16 // add top + bottom padding
    }
}
