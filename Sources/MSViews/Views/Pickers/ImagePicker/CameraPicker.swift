//
//  File.swift
//  
//
//  Created by Corptia 02 on 09/08/2023.
//

import Foundation
import SwiftUI

struct CameraPicker: View {
    @State private var selectedImage: UIImage?
    @State private var fileUrl: URL?
    @State private var isImagePickerPresented = false
    
    var body: some View {
        VStack {
            if let selectedImage = selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
            } else {
                Text("No Image Selected")
            }
            
            Button("Select Image") {
                isImagePickerPresented.toggle()
            }
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(sourceType: .constant(.camera), selectedImage: $selectedImage , fileUrl : $fileUrl)
        }
    }
}

public struct ImagePicker: UIViewControllerRepresentable {
    @Binding var  sourceType: UIImagePickerController.SourceType
    @Binding var selectedImage: UIImage?
    var onImageSet : ((UIImage , URL?) -> Void)? = nil
    @Binding var fileUrl: URL?
    @Environment(\.presentationMode) private var presentationMode
    
    public init(sourceType: Binding<UIImagePickerController.SourceType>, selectedImage: Binding<UIImage?>, onImageSet: ((UIImage, URL?) -> Void)? = nil, fileUrl: Binding<URL?>) {
            self._sourceType = sourceType
            self._selectedImage = selectedImage
            self.onImageSet = onImageSet
        self._fileUrl = fileUrl
        }
    
    
    public func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        imagePicker.sourceType = sourceType// or .camera for using the camera
        print("TEST \(sourceType)")
        
        return imagePicker
    }
    
    public func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // Nothing to update here
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    public class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        public func imagePickerController(
            _ picker: UIImagePickerController
            , didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
        ) {
            dump(info[.originalImage])
            
            if let selectedImage = info[.originalImage] as? UIImage {
                print(selectedImage)
                parent.selectedImage = selectedImage
                if let onImageSet = parent.onImageSet {
                    onImageSet(selectedImage , nil)
                }
                // Save the image to a temporary file
//                Task {
//                    do {
//                        let data = selectedImage.jpegData(compressionQuality: 0.8)
//                        try await saveImageToTemporaryFile(data: data)
//                    } catch {
//                        print(error)
//                    }
//                }
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        
        private func saveImageToTemporaryFile(data: Data?) async throws {
            guard let data = data else {
                throw NSError(domain: "YourAppDomain", code: -1, userInfo: ["message": "Failed to get image data"])
            }
            
            let temporaryDirectory = FileManager.default.temporaryDirectory
            let temporaryFileURL = temporaryDirectory.appendingPathComponent(UUID().uuidString).appendingPathExtension("png")
            
            try await data.write(to: temporaryFileURL)
            
            parent.fileUrl = temporaryFileURL
        }
        
    }
}
