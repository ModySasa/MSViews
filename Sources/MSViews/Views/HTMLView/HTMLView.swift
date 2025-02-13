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
                    .characterEncoding: String.Encoding.utf8.rawValue
                ]
                
                let attributedString = try NSMutableAttributedString(
                    data: data,
                    options: options,
                    documentAttributes: nil
                )
                
                // Set font
                let range = NSRange(location: 0, length: attributedString.length)
                attributedString.addAttribute(.font, value: UIFont(name: appFontName, size: 14) ?? UIFont.systemFont(ofSize: 14), range: range)
                attributedString.addAttribute(.foregroundColor, value: fontColor, range: range)
                
                // Detect language
                let detectedLang = NSLinguisticTagger.dominantLanguage(for: htmlString)
                let isRTL = detectedLang == "ar" || detectedLang == "he"
                
                // Set alignment based on language
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = isRTL ? .right : .left
                attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: range)
                
                // Apply to UITextView
                uiView.attributedText = attributedString
                uiView.backgroundColor = color
                uiView.textAlignment = isRTL ? .right : .left
                uiView.semanticContentAttribute = isRTL ? .forceRightToLeft : .forceLeftToRight
            }
        } catch {
            print("Error parsing HTML: \(error)")
        }
    }
}


struct HTMLView_Previews: PreviewProvider {
    static var previews: some View {
        HTMLView("Test me now\n Who cares?" , color: .clear)
    }
}

