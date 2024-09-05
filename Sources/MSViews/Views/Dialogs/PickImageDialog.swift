//
//  SwiftUIView.swift
//  
//
//  Created by Corptia 02 on 10/08/2023.
//

import SwiftUI

public struct PickImageDialog: View {
    @Binding public var showDialog: Bool
    public var dismissByClick : Bool = true
    public var onImageSet : ((UIImage , URL?)->Void)?
    
    public init(
        showDialog: Binding<Bool>
        , dismissByClick: Bool = true
        , onImageSet: ((UIImage,URL?) -> Void)? = nil
    ) {
        self._showDialog = showDialog
        self.dismissByClick = dismissByClick
        self.onImageSet = onImageSet
    }
    
    public var body: some View {
        CommonNoButtonsDialog(dismissByClick: dismissByClick , showDialog: $showDialog) {
            
        } content :{
            ImagePickerDialog(hasBorder: false , onImageSet:onImageSet)
        }
    }
}

struct PickImageDialog_Previews: PreviewProvider {
    static var previews: some View {
        PickImageDialog(showDialog: .constant(true))
    }
}

