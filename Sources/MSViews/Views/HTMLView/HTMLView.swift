//
//  SwiftUIView.swift
//
//
//  Created by Mohamed safwat on 14/11/2023.
//

import SwiftUI

public struct HTMLView: UIViewRepresentable {
    public let htmlString: String
    public let color: UIColor
    public let fontColor: UIColor
    
    public init(_ htmlString:String , color : UIColor = .clear , fontColor: UIColor = .white) {
        self.htmlString = htmlString
        self.color = color
        self.fontColor = fontColor
    }
    
    public func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isEditable = false
        textView.dataDetectorTypes = .all
        return textView
    }
    
    public func updateUIView(_ uiView: UITextView, context: Context) {
        do {
            if let data = htmlString.data(using: .utf8) {
                let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue // Specify the text encoding
                ]
                
                let attributedString = try NSAttributedString(
                    data: data,
                    options: options,
                    documentAttributes: nil
                )
                uiView.attributedText = attributedString
                
                // Specify a font that supports Arabic characters
                uiView.font = UIFont(name: appFontName, size: 14) // Replace with a suitable Arabic font and size
                uiView.backgroundColor = color
                uiView.textColor = fontColor
            }
        } catch {
            print("Error parsing HTML: \(error)")
        }
    }
}


struct HTMLView_Previews: PreviewProvider {
    static var previews: some View {
        HTMLView("Test me now" , color: .clear)
    }
}

