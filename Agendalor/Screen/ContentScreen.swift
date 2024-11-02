//
//  ContentScreen.swift
//  Agendalor
//
//  Created by 黒川良太 on 2024/10/30.
//

import SwiftUI

struct ContentScreen: View {
    @State private var offset: CGFloat = 0
    @State private var lastDragOffset: CGFloat = 0
    @State private var progress: CGFloat = 0
    @State private var isShowingSideBar = false
    
    var body: some View {
        NavigationStack {
            GeometryReader {
                let size = $0.size
                let sideBarWidth: CGFloat = 240
                
                ZStack(alignment: .leading) {
                    SideBar()
                        .frame(width: sideBarWidth)
                        .offset(x: -sideBarWidth)
                        .offset(x: offset)
                    RecordingScreen()
                        .offset(x: sideBarWidth * progress)
                        .offset(x: size.width / 4)
                }
                .gesture(DragGesture()
                    .onChanged { value in
                        let translation = value.translation.width + lastDragOffset
                        offset = max(0, min(translation, sideBarWidth))
                        progress = max(min(translation / sideBarWidth, 1), 0)
                    }
                    .onEnded { value in
                        let velocity = value.predictedEndTranslation.width / 3
                        
                        withAnimation(.snappy(duration: 0.25, extraBounce: 0)) {
                            if (velocity * offset) > (sideBarWidth / 2) {
                                offset = sideBarWidth
                                progress = 1
                                isShowingSideBar.toggle()
                            } else if velocity < 0 {
                                offset = 0
                                progress = 0
                                isShowingSideBar.toggle()
                            } else {
                                offset = 0
                                progress = 0
                            }
                        }
                        lastDragOffset = offset
                    }
                )
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            if !isShowingSideBar {
                                withAnimation {
                                    offset = sideBarWidth
                                    progress = 1
                                    isShowingSideBar.toggle()
                                }
                            } else {
                                withAnimation {
                                    offset = 0
                                    progress = 0
                                    isShowingSideBar.toggle()
                                }
                            }
                        } label: {
                            if isShowingSideBar {
                                Image(systemName: "multiply")
                                    .font(.title3)
                                    .opacity(0.5)
                                    .transition(.scale)
                            } else {
                                Image(systemName: "line.horizontal.3")
                                    .font(.title3)
                                    .transition(.scale)
                            }
                        }
                        
                    }
                }
            }
//            .ignoresSafeArea()
        }
    }
}

#Preview {
    ContentScreen()
}
