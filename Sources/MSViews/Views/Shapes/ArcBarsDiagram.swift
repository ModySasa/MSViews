//
//  ArcBarsDiagram.swift
//  Delta dream
//
//  Created by Moha on 1/5/26.
//

import SwiftUI

public struct ArcBarsDiagram : View {
    let items : [DataEntity]
    var lineWidth: CGFloat = 10
    var padding: CGFloat = 20
    
    var total : Double {
        items.reduce(0) { $0 + $1.data }
    }
    
    public init(items: [DataEntity], lineWidth: CGFloat, padding: CGFloat) {
        self.items = items
        self.lineWidth = lineWidth
        self.padding = padding
    }
    
    public var body: some View {
        ZStack {
            if(!items.isEmpty) {
                ForEach(items, id: \.id) { item in
                    let index = items.firstIndex { it in
                        item.id == it.id
                    }
                    theArc(
                        item: item ,
                        nextItem: (index ?? 0) < (items.count - 1) ? items[(index ?? 0) + 1] : nil ,
                        previousItem: (index ?? 0) > 0 ? items[(index ?? 0) - 1] : nil
                    )
                }
                .onAppear(perform: {
                    let duration: Double = 0.1

                    for i in 0..<items.count {
                        animatedEndAngles[i] = startAngles[i]

                        withAnimation(
                            .easeOut(duration: duration)
                            .delay(Double(i) * duration)
                        ) {
                            animatedEndAngles[i] = endAngles[i]
                        }
                    }
                })
            }
        }
        .onAppear {
            animatedEndAngles = .init(repeating:0 , count: items.count)
            for i in 0..<items.count {
                if i == 0 {
                    startAngles.append(0)
                } else {
                    let previousItem = i > 0 ? items[i - 1] : nil
                    if let previousItem {
                        startAngles.append(calculateEndAngle(item: previousItem))
                    } else {
                        startAngles.append(0)
                    }
                }
                endAngles.append(calculateEndAngle(item: items[i]))
            }
            print(animatedEndAngles , startAngles , endAngles)
        }
    }
    
    @State private var animatedEndAngles: [Double] = []
    
    @State private var startAngles: [Double] = []
    
    @State private var endAngles: [Double] = []
    
    @ViewBuilder
    func theArc(item : DataEntity , nextItem : DataEntity? = nil , previousItem : DataEntity? = nil) -> some View {
        if(!startAngles.isEmpty && !endAngles.isEmpty && !animatedEndAngles.isEmpty) {
            let index = items.firstIndex(of: item) ?? 0
            let startAngle : Double = startAngles[index]
            let endAngle : Double = endAngles[index]
            
            ArcBarsPath(
                startAngle: startAngle,
                endAngle: animatedEndAngles[index],
                insetAmount: 0
            )
            .strokeBorder(lineWidth: 10)
            .foregroundStyle(item.color)
            .overlay {
                GeometryReader { geo in
                    let r = min(geo.size.width, geo.size.height) / 2
                    let midAngle = (startAngle + endAngle) / 2
                    let angle = Angle.degrees(midAngle)
                    
                    let textRadius = r + lineWidth / 2 + padding
                    
                    let x = geo.size.width / 2 + cos(angle.radians) * textRadius
                    let y = geo.size.height / 2 + sin(angle.radians) * textRadius
                    
                    if(item.showPercentage) {
                        Text(item.customTitle ?? "\( String(format: "%.02f", item.data / total))%")
                            .position(x: x, y: y)
                            .foregroundStyle(
                                item.percentageColor ?? item.color
                            )
                    }
                }
            }
        }
    }
    
    func calculateEndAngle(item: DataEntity) -> Double {
        if item == items.first! {
            return (item.data / total) * 360
        } else {
            if let index = items.firstIndex(where: { it in
                it.id == item.id
            }) {
                let previous = items[0..<index].reduce(0) { $0 + $1.data }
                return ((previous + item.data) / total) * 360
            } else {
                return (item.data / total) * 360
            }
        }
    }
    
    func calculateStartAngle(item: DataEntity) -> Double {
        if item == items.first! {
            return (item.data / total) * 360
        } else {
            if let index = items.firstIndex(where: { it in
                it.id == item.id
            }) {
                let previous = items[0..<index].reduce(0) { $0 + $1.data }
                return (previous / total) * 360
            } else {
                return (item.data / total) * 360
            }
        }
    }
    
    public struct DataEntity : Identifiable , Equatable {
        public let id : String = UUID().uuidString
        let data : Double
        let color : Color
        let showPercentage: Bool
        let percentageColor : Color?
        let customTitle: String?
        
        public static func == (lhs: DataEntity, rhs: DataEntity) -> Bool {
            lhs.id == rhs.id
        }
        
        public init(
            data: Double,
            color: Color,
            showPercentage: Bool,
            percentageColor: Color? = nil,
            customTitle: String? = nil
        ) {
            self.data = data
            self.color = color
            self.showPercentage = showPercentage
            self.percentageColor = percentageColor
            self.customTitle = customTitle
        }
    }
}

struct ArcBarsPath: InsettableShape {
    var startAngle : Double = 0
    var endAngle : Double
    var insetAmount: CGFloat = 0
    let defaultAngel : Double = 90
    
    var animatableData: Double {
        get { endAngle }
        set { endAngle = newValue }
    }
    
    public func path(in rect: CGRect) -> Path {
        let r = min(rect.width, rect.height) / 2 - insetAmount
        
        return Path { path in
            path.addArc(
                center: CGPoint(x: rect.midX, y: rect.midY),
                radius: r,
                startAngle: .degrees(startAngle),
                endAngle: .degrees(endAngle),
                clockwise: false
            )
        }
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var copy = self
        copy.insetAmount += amount
        return copy
    }
}

#Preview {
    ArcBarsDiagram (
        items : [
            .init(data: 30, color: .green, showPercentage: true, percentageColor: nil)
            ,.init(data: 50, color: .blue, showPercentage: true, percentageColor: nil)
            ,.init(data: 40, color: .orange, showPercentage: true, percentageColor: nil)
            ,.init(data: 100, color: .cyan, showPercentage: true, percentageColor: nil)
            ,.init(data: 70, color: .red, showPercentage: true, percentageColor: nil)
        ],
        lineWidth: 15,
        padding: 30
    )
    .frame(width: 150, height: 150, alignment: .center)
}
