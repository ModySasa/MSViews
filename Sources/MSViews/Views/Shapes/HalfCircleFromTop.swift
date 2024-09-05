//
//  File.swift
//  
//
//  Created by Mohamed safwat on 28/11/2023.
//

import SwiftUI

public struct HalfCircleFromTop: Shape {
    @State public var radius : CGFloat
    
    public init(radius:CGFloat) {
        self.radius = radius
    }
    
    public func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint.init(x: rect.minX, y: rect.minY))
            path.addLine(to: .init(x: rect.maxX, y: rect.minY))
            path.addLine(to: .init(x: rect.maxX, y: rect.maxY / 2))
            path.addLine(to: .init(x: rect.minX, y: rect.maxY / 2))
            
            path.move(to: .init(x: rect.minX, y: rect.maxY / 2))
            path.addArc(center: .init(x:rect.midX , y: rect.maxY / 2), radius: radius, startAngle: .degrees(0), endAngle: .degrees(180), clockwise: false)
        }
    }
}
