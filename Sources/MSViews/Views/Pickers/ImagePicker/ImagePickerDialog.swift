//
//  SwiftUIView.swift
//  
//
//  Created by Corptia 02 on 09/08/2023.
//

import SwiftUI
import PhotosUI

struct ImagePickerDialog: View {
    @State var selectedImage : UIImage? = nil
    @State var fileUrl : URL? = nil
    @State private var isImagePickerPresented = false
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    var hasBorder : Bool = false
    var onImageSet : ((UIImage , URL?) -> Void)? = nil
    
    var body: some View {
            RoundedRectangle(cornerRadius: 15)
                .stroke(
                    style:
                            .init(
                                lineWidth: hasBorder ? 1 : 0
                                , lineCap: .butt
                                , lineJoin: .miter
                                , dash: [1,0]
                                , dashPhase: 0
                            )
                )
                .foregroundColor(msViews.viewsHelper.mainAppColor)
                .frame(height: 100)
//                .frame(maxWidth: .infinity)
                .padding(.horizontal, msViews.margins.mainMarginHorizontal)
                .overlay(alignment: .center) {
                    HStack {
                        Spacer()
                        HStack {
                            if #available(iOS 16.0, *) {
                                PhotoPicker16(onImageSet: onImageSet)
                            } else {
                                Image(systemName: "photo.artframe")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, alignment: .center)
                                    .onTapGesture {
                                        sourceType = .photoLibrary
                                        isImagePickerPresented.toggle()
                                    }
                            }
                        }
                        .frame(width: 50, alignment: .center)
                        Spacer()
                        
                        Image(systemName: "camera")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, alignment: .center)
                            .onTapGesture {
                                sourceType = .camera
                                isImagePickerPresented = true
                            }
                        Spacer()
                    }
                    .foregroundColor(msViews.viewsHelper.mainAppColor)
                }
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePicker(sourceType: $sourceType, selectedImage: $selectedImage , onImageSet: onImageSet, fileUrl : $fileUrl)
                }
    }
}

struct ImagePickerDialog_Previews: PreviewProvider {
    static var previews: some View {
        ImagePickerDialog()
    }
}

@available(iOS 16.0, *)
struct PhotoPicker16 : View {
    @StateObject var pickerViewModel = PhotoPickerViewModel16()
    var onImageSet : ((UIImage , URL?)->Void)? = nil
    var body: some View {
        PhotosPicker(selection: $pickerViewModel.selectedPickerItem , matching: .images) {
            Image(systemName: "photo.artframe")
                .resizable()
                .scaledToFit()
        }
        .onAppear {
            pickerViewModel.onImageSet = onImageSet
        }
    }
}
