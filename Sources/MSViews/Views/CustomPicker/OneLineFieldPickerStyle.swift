//
//  SwiftUIView.swift
//  
//
//  Created by Corptia 02 on 15/08/2023.
//

import SwiftUI

public struct OneLineFieldPickerStyle: View {
    @Binding public var selection : Int
    @Binding public var list : [PickerItem]
    @Binding public var error : String
    @State public var showList : Bool = false
    public var title : String = ""
    public var message : String = ""
    
    public init(
        selection: Binding<Int>
        , list: Binding<[PickerItem]>
        , error: Binding<String>
        , showList: Bool = false
        , title: String = ""
        , message: String = ""
    ) {
        self._selection = selection
        self._list = list
        self._error = error
        self.showList = showList
        self.title = title
        self.message = message
    }
    
    public var body: some View {
        ZStack(alignment:.top){
            if(!list.isEmpty) {
                //FIELD WITH IMAGE
                OneLineField(
                    txt: $list[selection].title
                    , errorText: $error
                    , placeHolder: list[selection].title
                    , isPassword: false
                    , disabled: true
                    , padding: 15
                    , radius: 10
                    , textSize: 14
                    , textWeight: .regular
                    , onSubmit: { _ in}
                    , onTextChange: { _ in}
                )
                .overlay(alignment: .trailing, content: {
                    Image(systemName:"chevron.right")
                        .rotationEffect(
                            Angle(
                                degrees: showList ? (msViews.langMethods.isArabic() ? -90 : 90)
                                : 0)
                            , anchor: .center)
                        .padding(.trailing, 15)
                })
                .onTapGesture {
                    withAnimation(.spring(blendDuration: 1)) {
                        showList.toggle()
                    }
                }
            }
        }
        .confirmationDialog(
            Text(title)
            , isPresented: $showList
            , titleVisibility: title.isEmpty ? .hidden : .visible
        ) {
            VStack(alignment: .center, spacing: 0) {
                ForEach($list, id: \.self) { item in
                    Button(role: selection == item.id ? .destructive : .none) {
                        withAnimation(.spring()) {
                            selection = item.id
                            showList = false
                        }
                    } label: {
                        HStack(alignment: .center) {
                            Text(item.title.wrappedValue)
                                .foregroundColor(.red)
                        }
                        .padding(.top , 10)
                        .background(
                            Color.white.opacity(0.001)
                        )
                    }
                }
            }
        } message: {
            Text(message)
        }
    }
}

struct OneLineFieldPickerStylePreviewHelper : View {
    @State var selection = 0
    @State var list = [PickerItem].init(
        arrayLiteral:
                .init(id: 0 , title: strings("addNotes") , object: 5)
        , .init(id: 1 , title: strings("Next") , object: 8)
        , .init(id: 2 , title: strings("aboutUs") , object: 8)
    )
    
    @State var errorMsg : String = ""
    
    var body: some View {
        OneLineFieldPickerStyle(
            selection: $selection
            , list: $list
            , error: $errorMsg
        )
    }
}

struct OneLineFieldPickerStylePreviewProvider: PreviewProvider {
    static var previews: some View {
        OneLineFieldPickerStylePreviewHelper()
    }
}
