//
//  SwiftUIView.swift
//  
//
//  Created by Mohamed safwat on 02/11/2023.
//

import SwiftUI

public struct StaggeredGridView<Cell:View>: View {
    let width : CGFloat
    let textSize : CGFloat
    let spacing: CGFloat
    let horizontalPadding: CGFloat
    let cellHeight: CGFloat
    let lineSpacing: CGFloat
    var pushToLeading : Bool = false
    let list : Binding<[any Identifiable]>
    let stringsList : Binding<[String]>
    let cell : ((any Identifiable)-> Cell)
    
    public init(
        width: CGFloat
        , textSize: CGFloat
        , spacing: CGFloat
        , horizontalPadding: CGFloat
        , cellHeight: CGFloat
        , lineSpacing: CGFloat
        , pushToLeading: Bool
        , list: Binding<[any Identifiable]>
        , stringsList: Binding<[String]>
        , cell: @escaping (any Identifiable) -> Cell
    ) {
        self.width = width
        self.textSize = textSize
        self.spacing = spacing
        self.horizontalPadding = horizontalPadding
        self.cellHeight = cellHeight
        self.lineSpacing = lineSpacing
        self.pushToLeading = pushToLeading
        self.list = list
        self.stringsList = stringsList
        self.cell = cell
    }
    
    public var body: some View {
        let counts = getCount()
//        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                if(!list.isEmpty){
                    ForEach(1...counts.lines, id: \.self) { index in
                        HStack(spacing: spacing){
                            catsList(
                                counts.cells
                                , lineIndex: index
                            )
                            .padding(0.5)
                            if(pushToLeading) {
                                Spacer()
                            }
                        }
                    }
                }
            }
//        }
        .frame(
            maxWidth: width
            , maxHeight: (CGFloat(counts.lines) * cellHeight) + (lineSpacing + CGFloat(counts.lines))
        )
    }
    
    @State private var cellSizes: [CGSize] = []
    
    func getCount() -> (lines: Int, cells: Int) {
        if(list.isEmpty) {
            return (0,0)
        }
        var lines = 1
        var cellsPerLine = 1
        let totalWidth = calculateDynamicWidths()

        var lineWidth = 0.0
        var oneLineCells = 0
        for i in 0..<totalWidth.count {
            let cellWidth = totalWidth[i]
            let pureWidth = lineWidth + cellWidth
            let totalSpacingInLine = CGFloat(cellsPerLine - 1) * spacing
            
            let toBeTotalWidth = pureWidth + totalSpacingInLine
            if(toBeTotalWidth > width) {
                lines += 1
                lineWidth = 0
                oneLineCells = 0
            } else {
                oneLineCells += 1
                cellsPerLine = max(oneLineCells , cellsPerLine)
                lineWidth = pureWidth + totalSpacingInLine
            }
            
        }
        
        return (lines: lines , cells: cellsPerLine)
    }
    
    func calculateDynamicWidths() -> [CGFloat] {
        return stringsList.map { string in
            let textWidth = getTextWidth(from: string.wrappedValue)
            return textWidth
        }
    }
    
    func getTextWidth(from string: String) -> CGFloat {
        let baseFont = UIFont.init(descriptor: UIFontDescriptor.init(
            fontAttributes: [.name : appFontName]), size: textSize)
                                   
        let size = string.size(with: baseFont)
        return min(size.width + horizontalPadding, width)
    }

    func catsList(
        _ itemsCount : Int
        , lineIndex : Int
    ) -> some View {
        ForEach(getStart(itemsCount , lineIndex)..<getEnd(itemsCount, lineIndex , list.count) , id: \.self) { ind in
            cell(list[ind].wrappedValue)
        }
    }
    
    func getStart(_ itemsCount:Int ,_ lineIndex:Int) -> Int {
        if(lineIndex == 1) {
            return 0
        } else {
            return itemsCount * (lineIndex - 1)
        }
    }
    
    func getEnd(_ itemsCount:Int ,_ lineIndex:Int , _ size : Int) -> Int {
        if(lineIndex == 1) {
            return itemsCount
        } else {
            if(lineIndex * itemsCount < size) {
                return lineIndex * itemsCount
            } else {
                return size
            }
        }
    }
    
}

struct MeasureSizeModifier: ViewModifier {
    @Binding var size: CGSize

    func body(content: Content) -> some View {
        content.background(
            GeometryReader { geo in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geo.size)
            }
        )
    }
}

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

//struct StaggeredGridView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        let cats = [CategoryModel].init(arrayLiteral:
//                                            CategoryModel.random(1)
//                                        , CategoryModel.random(2)
//                                        , CategoryModel.random(3)
//                                        , CategoryModel.random(4)
//                                        , CategoryModel.random(5)
////                                        , CategoryModel.random(1)
////                                        , CategoryModel.random(2)
//                                         )
//
//        StaggeredGridView(
//            width:helper.viewsHelper.screenWidth()
//            , textSize: 20
//            , spacing: 10
//            , horizontalPadding: 25
//            , cellHeight: 50
//            , lineSpacing: 10
//            , list: .constant(cats)
//            , stringsList: .constant(cats.map({ cat in
//                return cat.name
//            }))
//        ){ cat in
//            CategoryCell(
//                category: .constant(cat as! CategoryModel)
//                , selectedCategory: .constant(CategoryModel.random(1))
//            )
//        }
//    }
//}
