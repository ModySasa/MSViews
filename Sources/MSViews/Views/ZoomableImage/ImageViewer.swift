
//
//  ContentView.swift
//  ImageHandlingApp
//
//  Created by mohammed on 17/02/2024.
//

import SwiftUI

struct ImageViewer: View {
    //Properties
    @State var imageScale : CGFloat = 1
    @State var imageOffset : CGSize = .zero
    @State var position : CGSize = .zero
    let imageUrl : String
    @State var coverIndex = 0
    var onCloseClicked : () -> Void = {}
    
    private func resetImage(){
        imageScale = 1
        imageOffset = .zero
        position = .zero
    }
    
    //Body
    var body: some View {
        VStack {
            Button {
                onCloseClicked()
            } label: {
                Image(systemName: "xmark")
            }
            .foregroundStyle(.red)
            .padding(.trailing , 30)
            .frame(maxWidth: .infinity , alignment:  .trailing)
            
            Spacer()

            ImageLoader(url: imageUrl, width: msViews.viewsHelper.screenWidth() - 40 , height: 300.resize()) {
                Image(.masterPlan)
                    .resizable()
            } progressView: {
                ProgressView()
            }
            .clipShape(.rect(cornerRadius: 10))
            .padding()
            .scaleEffect(imageScale)
            .offset(x: imageOffset.width + position.width, y: imageOffset.height + position.height)
            .shadow(color: Color(red: 0, green: 0, blue: 0 , opacity: 0.35), radius: 8, x: 3, y: 3)
            
            //1. Double tap gesture
            .onTapGesture(count: 2, perform: {
                withAnimation(.spring()) {
                    if imageScale == 1 {
                        imageScale = 5
                    }else {
                        resetImage()
                    }
                }
            })
            
            //2. Drag Gesture
            .gesture(DragGesture()
                .onChanged({ gesture in
                    imageOffset = gesture.translation
                })
                    .onEnded({ value in
                        withAnimation(.spring()) {
                            if imageScale <= 1 {
                                resetImage()
                            }else {
                                position.width += value.translation.width
                                position.height += value.translation.height
                                imageOffset = .zero
                            }
                        }
                    }))
            //3. Magnification gesture
            .gesture(MagnificationGesture()
                .onChanged({ magnify in
                    withAnimation(.spring()) {
                        if imageScale >= 1 && imageScale <= 5 {
                            imageScale = magnify
                        }else if imageScale > 5 {
                            imageScale = 5
                        } else if imageScale < 1{
                            imageScale = 1
                        }
                    }
                })
                    .onEnded({ value in
                        withAnimation(.spring()) {
                            if imageScale > 5 {
                                imageScale = 5
                            }else if imageScale < 1 {
                                imageScale = 1
                            }
                        }
                        
                    }))
            
            // Control view
            .overlay(alignment: .bottom) {
                ControlView(imageScale: $imageScale, imageOffset: $imageOffset , position: $position)
            }
            Spacer()
        }
    }
}

struct ControlView: View {
    
    @Binding var imageScale : CGFloat
    @Binding var imageOffset : CGSize
    @Binding var position : CGSize
    
    var body: some View {
        HStack{
            Button {
                if imageScale > 1 {
                    imageScale = imageScale - 0.5
                }else{
                    imageOffset = .zero
                    position = .zero
                }
            } label: {
                Image(systemName: "minus.magnifyingglass")
                    .font(.title2)
            }
            
            Button {
                imageScale = 1
                imageOffset = .zero
                position = .zero
            } label: {
                Image(systemName: "arrow.up.left.and.down.right.magnifyingglass")
                    .font(.title2)
            }
            
            Button {
                if imageScale < 5 {
                    imageScale = imageScale + 0.5
                }
            } label: {
                Image(systemName: "plus.magnifyingglass")
                    .font(.title2)
            }

        }//: Hstack
        .padding(.vertical , 5)
        .padding(.horizontal , 15)
        .foregroundStyle(.white)
        .background(.ultraThinMaterial)
        .clipShape(.rect(cornerRadius: 16))
        .font(.largeTitle)
    }
}

#Preview {
    ImageViewer(imageUrl:"")
}

