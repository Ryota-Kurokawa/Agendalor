//
//  RecordingScreen.swift
//  Agendalor
//
//  Created by 黒川良太 on 2024/10/30.
//

import SwiftUI

struct RecordingScreen: View {
    @State var isPressed: Bool = false
    
    var body: some View {
        VStack {
            if isPressed {
                Text("Recording")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 32)
                    .transition(.identity)
                Spacer()
                LottieView(filename: "Recording")
                    .frame(width: 400, height: 400)
                    .transition(.scale)
                    .onTapGesture {
                        withAnimation {
                            isPressed.toggle()
                        }
                    }
                Spacer()
            } else {
                Text("No Recording")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 32)
                    .transition(.identity)
                Spacer()
                Image(systemName: "mic.slash")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .transition(.scale)
                    .onTapGesture {
                        withAnimation {
                            isPressed.toggle()
                        }
                    }
                Spacer()
            }
        }
    }
    
}

#Preview {
    RecordingScreen()
}
