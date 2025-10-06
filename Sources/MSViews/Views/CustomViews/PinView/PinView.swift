//
//  SwiftUIView.swift
//  
//
//  Created by Corptia 02 on 27/04/2023.
//

import SwiftUI

public struct PinView: View {
    enum FocusedState : Int {
        case _1 = 1
        case _2 = 2
        case _3 = 3
        case _4 = 4
        case _5 = 5
        case _0 = 6
    }
    public enum PinStyle {
        case round
        case roundedCorner
        case square
    }
    var pinsCount = 6
    var style : PinStyle = .roundedCorner
    @Binding var code : String {
        didSet {
            onCodeEntered(code)
        }
    }
    var onCodeEntered : (String)->Void
    @State var txts = [String].init(repeating: "", count: 6)
    var backgroundColor : Color = .white
    var height : CGFloat = 40
    var width : CGFloat = 40
    var radius : CGFloat = 11.5
    var spacing : CGFloat = 10
    
    public init(
        _ code : Binding<String> ,
        pinsCount : Int = 6 ,
        style : PinStyle = .roundedCorner ,
        backgroundColor : Color = .white ,
        height : CGFloat = 40 ,
        width : CGFloat = 40 ,
        radius : CGFloat = 11.5 ,
        spacing : CGFloat = 10 ,
        onCodeEntered : @escaping (String)->Void
    ){
        self._code = code
        self.pinsCount = pinsCount
        self.style = style
        self.onCodeEntered = onCodeEntered
        self.backgroundColor = backgroundColor
        self.height = height
        self.width = width
        self.radius = radius
        self.spacing = spacing
        txts = [String].init(repeating: "", count: pinsCount)
    }
    
    @FocusState var focused : FocusedState?
    
    @State var b1 : String = ""
    
    func checkData(/*st : inout String ,*/ i : Int) {
        var st = bs[i].wrappedValue
        let before = self.txts[i]
        self.txts[i] = st
        var after = self.txts[i]
        if(before.count == 0 && after.count == 1) {
            forwardChange(i , before: before)
        } else if (before.count == 1 && after.count == 0) {
            backChange()
        } else if(before.count == 1) {
            if(after.count == 2) {
                forwardChange(i , before:before)
                self.txts[i] = before
                st = self.txts[i]
                if(focused != nil){
                    if ((focused!.rawValue) < (pinsCount - 1)) {
                        self.txts[i + 1] = "\(after.last!)"
                        bs[i + 1].wrappedValue = self.txts[i + 1]
                        forwardChange(i , before: before)
                    }
                }
                
            } else if(after.count > 2){
                forwardChange(i , before:before)
                self.txts[i] = before
                st = self.txts[i]
                print("afterCount " , after.count)
                if(focused != nil){
                    if ((focused!.rawValue) < (pinsCount - 1)) {
                        after.removeFirst()
                        self.txts[i + 1] = "\(after.first!)"
                        bs[i + 1].wrappedValue = self.txts[i + 1]
                        forwardChange(i , before: before)
                        
                        if(focused != nil){
                            if ((focused!.rawValue) < (pinsCount - 1)) {
                                after.removeFirst()
                                self.txts[i + 2] = "\(after.first!)"
                                bs[i + 2].wrappedValue = self.txts[i + 2]
                                forwardChange(i + 1 , before: self.txts[i + 1])
                                if(focused != nil){
                                    if ((focused!.rawValue) < (pinsCount - 1)) {
                                        after.removeFirst()
                                        self.txts[i + 3] = "\(after.first!)"
                                        bs[i + 3].wrappedValue = self.txts[i + 3]
                                        forwardChange(i + 2, before: before)
                                    }
                                    if(focused != nil){
                                        if ((focused!.rawValue) < (pinsCount - 1)) {
                                            after.removeFirst()
                                            self.txts[i + 4] = "\(after.first!)"
                                            bs[i + 4].wrappedValue = self.txts[i + 4]
                                            forwardChange(i + 3, before: before)
                                            
                                            if ((focused!.rawValue) < (pinsCount - 1)) {
                                                after.removeFirst()
                                                self.txts[i + 5] = "\(after.first!)"
                                                bs[i + 5].wrappedValue = self.txts[i + 5]
                                                forwardChange(i + 4, before: before)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } else {
                for m in 0..<min(after.count , pinsCount) {
                    self.txts[m] = "\(after.first!)"
                    bs[m].wrappedValue = self.txts[m]
                    after.removeFirst()
                    focused = nil
                }
            setCode()
        }
    }
    
    @State var b2 : String = ""
    @State var b3 : String = ""
    @State var b4 : String = ""
    @State var b5 : String = ""
    @State var b6 : String = ""
    
    var bs : [Binding<String>] {
        var list = [Binding<String>].init(arrayLiteral: $b1)
        if(pinsCount > 1) {
            list.append($b2)
        }
        if(pinsCount > 2) {
            list.append($b3)
        }
        if(pinsCount > 3) {
            list.append($b4)
        }
        if(pinsCount > 4) {
            list.append($b5)
        }
        if(pinsCount > 5) {
            list.append($b6)
        }
        return list
    }
    
    public var body: some View {
        HStack(spacing:spacing){
            ForEach(0..<pinsCount) { i in
                Spacer()
                getTextStyleView()
                    .overlay(alignment: .center) {
                        TextField("",text: bs[i])
                            .multilineTextAlignment(.center)
//                            .onChange(of: txts[pinsCount - 1]) { newValue in
//                                textBinding = .constant(newValue)
//                            }
//                            .background(
//                                getTextStyleView()
//                            )
                            .frame(alignment: .center)
                            .keyboardType(.numberPad)
                            .focused($focused, equals: getFocused(i))
                    }
                    
                Spacer()
            }
        }
//        .frame(maxWidth:.infinity)
        .onChange(of: b1) { newValue in
            checkData(/*st: &b1 , */i: 0)
        }
        .onChange(of: b2) { newValue in
            checkData(/*st: &b2 , */i: 1)
        }
        .onChange(of: b3) { newValue in
            checkData(/*st: &b3 , */i: 2)
        }
        .onChange(of: b4) { newValue in
            checkData(/*st: &b4 , */i: 3)
        }
        .onChange(of: b5) { newValue in
            checkData(/*st: &b5 , */i: 4)
        }
        .onChange(of: b6) { newValue in
            checkData(/*st: &b6 , */i: 5)
        }
        .onChange(of: code, perform: { value in
            if(value.isEmpty){
                b1 = ""
                b2 = ""
                b3 = ""
                b4 = ""
                b5 = ""
                b6 = ""
                for i in 0..<pinsCount {
                    bs[i].wrappedValue = ""
                    txts[i] = ""
                }
            }
        })
        .environment(\.layoutDirection, .leftToRight)
    }
    
    //MARK: functions
    func forwardChange(_ index:Int , before : String){
        switch focused {
        case ._0:
            if(pinsCount > 0){
                focused = ._1
            } else {
                focused = nil
                txts[index] = before
            }
        case ._1:
            if(pinsCount > 1){
                focused = ._2
            } else {
                focused = nil
                txts[index] = before
            }
        case ._2:
            if(pinsCount > 2){
                focused = ._3
            } else {
                focused = nil
                txts[index] = before
            }
        case ._3:
            if(pinsCount > 3){
                focused = ._4
            } else {
                focused = nil
                txts[index] = before
            }
        case ._4:
            if(pinsCount > 4){
                focused = ._5
            } else {
                focused = nil
                txts[index] = before
            }
        default:
            setCode(false , index)
        }
        setCode(false , index)
    }
    
    func setCode(_ isBackword:Bool = false ,_ x : Int = -1 ){
        code = ""
        
        for i in 0..<pinsCount {
            if(bs[i].wrappedValue.count > 1) {
                bs[i].wrappedValue.removeLast()
            }
            if(code.count < pinsCount) {
                code = code + bs[i].wrappedValue
            }
        }
        print("PIN CODE IS" , code)
    }
    
    func backChange(){
        switch focused {
        case ._5:
            focused = ._4
        case ._4:
            focused = ._3
        case ._3:
            focused = ._2
        case ._2:
            focused = ._1
        case ._1:
            focused = ._0
        default:
            setCode(true)
        }
        setCode(true)
    }
    
    func getFocused(_ index: Int) -> FocusedState {
        switch index {
        case 1 :
            return ._1
        case 2:
            return ._2
        case 3:
            return ._3
        case 4:
            return ._4
        case 5:
            return ._5
        default :
            return ._0
        }
    }
    
    //MARK: Views
    var squareCornerStyle : some View {
        Rectangle()
            .stroke(
                style: .init(lineWidth: 1, lineCap: .butt, lineJoin: .bevel, miterLimit: 1, dash: [1,0], dashPhase: 0)
            )
            .fill(msViews.viewsHelper.secondBorderColor)
            .background(
                Rectangle()
                    .fill(backgroundColor)
            )
            .frame(width: width, height: height , alignment: .center)
    }
    
    var roundedCornerStyle : some View {
        RoundedRectangle(cornerRadius: (radius - 1.0))
            .stroke(
                style: .init(lineWidth: 1, lineCap: .butt, lineJoin: .bevel, miterLimit: 1, dash: [1,0], dashPhase: 0))
            .fill(msViews.viewsHelper.secondBorderColor)
            .background(
                RoundedRectangle(cornerRadius: radius)
                    .fill(backgroundColor)
            )
            .frame(width: width, height: height , alignment: .center)
    }
    
    var circleCornerStyle : some View {
        Circle()
            .stroke(
                style: .init(lineWidth: 1, lineCap: .butt, lineJoin: .bevel, miterLimit: 1, dash: [1,0], dashPhase: 0))
            .fill(msViews.viewsHelper.secondBorderColor)
            .background(
                Circle()
                    .fill(backgroundColor)
                    .frame(width: width , alignment: .center)
            )
            .frame(width: width , alignment: .center)
    }
    
    @ViewBuilder func getTextStyleView() -> some View {
        switch style {
        case .roundedCorner:
            roundedCornerStyle
        case .round:
            circleCornerStyle
        default:
            squareCornerStyle
        }
    }
    
}

struct PinViewPreviewHelper : View {
    @State var code = ""
    
    var body: some View {
        PinView(
            $code,
            pinsCount: 6,
            style: .round) { cde in
                print(cde)
            }
    }
}

struct PinView_Previews: PreviewProvider {
    static var previews: some View {
        PinViewPreviewHelper()
    }
}
