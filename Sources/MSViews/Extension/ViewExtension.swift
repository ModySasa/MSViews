//
//  ViewExtension.swift
//
//
//  Created by Mohammad on 13/02/2024.
//

import SwiftUI
import OSLog

public extension View {
    func getViewClassName<T: View>(_ view: T) -> String {
        let mirror = Mirror(reflecting: view)
        return String(describing: mirror.subjectType)
    }
    
    var log: Logger {
        if let bundleIdentifier = Bundle.main.bundleIdentifier {
            let logger = Logger(subsystem: bundleIdentifier, category: String(describing: type(of: self)))
            return logger
        } else {
            let logger = Logger(subsystem: "bundleIdentifier", category: String(describing: type(of: self)))
            return logger
        }
    }
    
    func logMessage(_ message:String, _ level:OSLogType = .info) -> some View {
        modifier(LogMod(logger: log, logLevel: level, logMessage: message))
    }
    
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
    
}

public struct LogMod : ViewModifier {
    var logger:Logger
    var logLevel : OSLogType
    var logMessage : String
    
    public func body(content:Content) -> some View {
        content
            .onAppear{
                logger.log(level: logLevel, "\(logMessage)")
            }
    }
    
}
