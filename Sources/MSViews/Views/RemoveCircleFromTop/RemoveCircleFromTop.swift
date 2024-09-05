//
//  RemoveCircleFromTop.swift
//  
//
//  Created by Mohamed safwat on 02/11/2023.
//

import SwiftUI

public struct RemoveCircleFromTop: Shape {
    public var circleRadiusToCut : CGFloat
    
    public init(_ circleRadiusToCut:CGFloat) {
        self.circleRadiusToCut = circleRadiusToCut
    }
    
    public func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint (x: rect.minX, y: rect.minY))
            
            path.addLine(to: CGPoint (x: rect.midX - circleRadiusToCut, y: rect.minY))
            path.addArc(
                center: .init(x:rect.midX, y: rect.minY)
                , radius: circleRadiusToCut
                , startAngle: Angle(degrees: 180)
                , endAngle: Angle(degrees: 90)
                , clockwise: true
            )
            
            path.addLine(to: CGPoint (x: rect.midX - circleRadiusToCut, y: rect.minY + circleRadiusToCut))
            
            path.addArc(
                center: .init(x:rect.midX, y: rect.minY)
                , radius: circleRadiusToCut
                , startAngle: Angle(degrees: 90)
                , endAngle: Angle(degrees: 0)
                , clockwise: true
            )
            
            path.addLine(to: CGPoint (x: rect.midX + circleRadiusToCut, y: rect.minY + circleRadiusToCut))
            
            path.addLine(to: CGPoint (x: rect.midX + circleRadiusToCut, y: rect.minY))
            
            
            path.addLine(to: CGPoint (x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint (x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint (x: rect.minX, y: rect.maxY))
        }
    }
}

struct RemoveCircleFromTop_Previews: PreviewProvider {
    static var previews: some View {
        RemoveCircleFromTop(30)
    }
}
