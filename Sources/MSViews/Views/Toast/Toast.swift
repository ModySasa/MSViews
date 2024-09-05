//
//  File.swift
//  
//
//  Created by Corptia 02 on 19/04/2023.
//

import Foundation
import SwiftUI
//import Alamofire

public class Toast : ObservableObject{
    @Published public var message : String
    @Published public var type : ToastType
    
    public enum FieldErrorCase {
        case phoneEmpty
        case phoneShort
        case passwordEmpty
        case passwordShort
        case confirmPasswordEmpty
        case confirmPasswordShort
        case confirmNotMatch
        case nameEmpty
        case nameShort
        case emptyMessage
    }
    
    public init(){
        message = ""
        type = .error
    }
    
    public init(message:String, type : ToastType = .error) {
        self.message = message
        self.type = type
    }
    
}

public enum ToastType {
    case error
    case success
    case info
    case warning
}
