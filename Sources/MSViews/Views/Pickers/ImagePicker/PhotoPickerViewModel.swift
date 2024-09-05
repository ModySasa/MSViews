//
//  File.swift
//  
//
//  Created by Corptia 02 on 09/08/2023.
//

import Foundation
import SwiftUI
import PhotosUI

@available(iOS 16.0, *)
@MainActor
open class PhotoPickerViewModel16 : ObservableObject {
    
    public init() {}

    @Published var selectedImage : UIImage? = nil {
        didSet {
            if let onImageSet , let selectedImage{
                onImageSet(selectedImage , fileUrl)
            }
        }
    }
    
    @Published public var selectedPickerItem : PhotosPickerItem? = nil {
        didSet {
            setImage(from: selectedPickerItem)
        }
    }
    @Published private(set) var selectedImages : [UIImage] = []
    @Published  var selectedPickerItems : [PhotosPickerItem] = [] {
        didSet {
            setImages(from: selectedPickerItems)
        }
    }
    
    private func setImage(from selection:PhotosPickerItem?){
        guard let selection else {return}
        
        Task {
            do {
                let data = try await selection.loadTransferable(type: Data.self)
                guard let data ,let uiImage = UIImage(data: data) else {
//                    try await saveImageToTemporaryFile(data: data!)
                    throw URLError
                        .init(.cannotDecodeRawData
                              , userInfo:
                                .init(
                                    dictionaryLiteral:
                                        ("message", "Failed to get image" as Any)
                                )
                        )
                }
                selectedImage = uiImage
            } catch {
                print(error)
            }
        }
    }
    
    var fileUrl : URL? = nil
    
    private func setImages(from selections:[PhotosPickerItem]){
        Task {
            var images = [UIImage]()
            for selection in selections {
                do {
                    let data = try await selection.loadTransferable(type: Data.self)
                    guard let data ,let uiImage = UIImage(data: data) else {
//                        try await saveImageToTemporaryFile(data: data!)
                        throw URLError
                            .init(.cannotDecodeRawData
                                  , userInfo:
                                    .init(
                                        dictionaryLiteral:
                                            ("message", "Failed to get image" as Any)
                                    )
                            )
                    }
                    images.append(uiImage)
                } catch {
                    print(error)
                }
            }
            selectedImages = images
        }
    }
    
    public var onImageSet : ((UIImage , URL?)->Void)? = nil
    
    private func saveImageToTemporaryFile(data: Data) async throws {
        let temporaryDirectory = FileManager.default.temporaryDirectory
        let temporaryFileURL = temporaryDirectory.appendingPathComponent(UUID().uuidString).appendingPathExtension("png")
        
        try await data.write(to: temporaryFileURL)
        
        fileUrl = temporaryFileURL
    }
}
