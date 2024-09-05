//
//  SwiftUIView.swift
//  
//
//  Created by Corptia 02 on 10/08/2023.
//

import SwiftUI

struct PickImageDialogExample: View {
    @State var showDialog : Bool = false
    @State var img : UIImage? = nil
    @State var toast : Toast = .init()
    
    var body: some View {
        ZStack{
            VStack {
                MainPage(toast: $toast, withScroll: true) {
                    if (img != nil) {
                        Image(uiImage: img!)
                            .resizable()
                            .frame(width: 100, height: 100, alignment: .center)
                    }
                } onRefresh: {
                    img = nil
                }
                Spacer()
                Button {
                    showDialog = true
                } label: {
                    Text("Pick the image")
                }
            }
            if(showDialog) {
                dialog
            }
        }
    }
    
    var dialog : some View {
        PickImageDialog(showDialog: $showDialog , dismissByClick : true) { image , url in
            self.img = image
            showDialog = false
        }
    }
}

struct PickImageDialogExample_Previews: PreviewProvider {
    static var previews: some View {
        PickImageDialogExample()
    }
}
