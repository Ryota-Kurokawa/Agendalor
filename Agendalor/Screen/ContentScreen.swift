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
                let sideBarWidth: CGFloat = size.width * 0.9
                
                ZStack(alignment: .leading) {
                    SideBar()
                        .frame(width: sideBarWidth)
                        .offset(x: -sideBarWidth)
                        .offset(x: offset)
                    RecordingScreen()
                        .offset(x: sideBarWidth * progress)
                        .offset(x: size.width / 4)
                }
                .contentShape(Rectangle())
                .gesture(DragGesture()
                    .onChanged { value in
                        let translation = value.translation.width + lastDragOffset
                        offset = max(0, min(translation, sideBarWidth))
                        progress = max(min(translation / sideBarWidth, 1), 0)
                    }
                    .onEnded { value in
                        let velocity = value.predictedEndTranslation.width / 3
                        withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.7, blendDuration: 0.5)) {
                            if (velocity * offset) > (sideBarWidth / 2) {
                                offset = sideBarWidth
                                progress = 1
                                isShowingSideBar = true
                            } else if velocity < 0 {
                                offset = 0
                                progress = 0
                                isShowingSideBar = false
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
                                }
                            } else {
                                withAnimation {
                                    offset = 0
                                    progress = 0
                                }
                            }
                            isShowingSideBar.toggle()
                            lastDragOffset = offset
                        } label: {
                            if isShowingSideBar {
                                Text("Back")
                                    .font(.title3)
                                    .opacity(0.5)
                                    .transition(.scale)
                            } else {
                                Image(systemName: "folder")
                                    .font(.title3)
                                    .transition(.scale)
                            }
                        }
                        
                    }
                }
            }
        }
    }
}

#Preview {
    ContentScreen()
}
