//
//  RecordingScreen.swift
//  Agendalor
//
//  Created by 黒川良太 on 2024/10/30.
//

import SwiftUI

struct RecordingScreen: View {
    @State var isPressed: Bool = false
    @State var isRecordingCompleted: Bool = false
    @State var isCheckedForCompletion: Bool = false
    private let speechRecognizer = SpeechRecognizer()
    
    var body: some View {
        VStack {
            if isPressed {
                Text("Recording")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 100)
                    .transition(.identity)
                Spacer()
                LottieView(filename: "Recording")
                    .frame(width: 200, height: 200)
                    .transition(.scale)
                    .onTapGesture {
                        withAnimation {
                            isPressed.toggle()
                            isRecordingCompleted.toggle()
                        }
                    }
                Spacer()
            } else {
                Text("No Recording")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 100)
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
        .alert(isPresented: $isRecordingCompleted) {
            Alert(title: Text("Recording Completed"), message: Text("Would you like to save the recording?"), primaryButton: .default(Text("Save"), action: {
                isCheckedForCompletion = true
            }), secondaryButton: .cancel(Text("Cancel"), action: {
                isRecordingCompleted = false
            }))
        }
        .navigationDestination(isPresented: $isCheckedForCompletion) {
            SampleScreen()
        }
        .onChange(of: isPressed) { _, newValue in
            if newValue {
                // 録音開始
                Task { @MainActor in
                    speechRecognizer.requestAuthorization { authorized in
                        if authorized {
                            do {
                                try speechRecognizer.startRecognition { text in
                                    if let recognizedText = text {
                                        DispatchQueue.main.async {
                                            print("Recognized Text: \(recognizedText)")
                                        }
                                    }
                                }
                            } catch {
                                DispatchQueue.main.async {
                                    print("Failed to start recognition: \(error.localizedDescription)")
                                }
                            }
                        } else {
                            print("Speech recognition permission denied")
                        }
                    }
                }
            } else {
                // 録音停止
                speechRecognizer.stopRecognition()
            }
        }
    }
    
}

#Preview {
    RecordingScreen()
}
