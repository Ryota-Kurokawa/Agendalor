import Foundation
import Speech
import AVFoundation

class SpeechRecognizer: NSObject, SFSpeechRecognizerDelegate {
    private let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer(locale: Locale(identifier:"ja_JP"))
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    override init() {
        super.init()
        speechRecognizer?.delegate = self
    }
    
    // マイクと音声認識の使用許可をリクエスト
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        SFSpeechRecognizer.requestAuthorization { status in
            switch status {
            case .authorized:
                completion(true)
            default:
                completion(false)
            }
        }
    }
    
    // 音声認識を開始
    func startRecognition(completion: @escaping (String?) -> Void) throws {
        guard let speechRecognizer = speechRecognizer, speechRecognizer.isAvailable else {
            throw NSError(domain: "SpeechRecognizer", code: 1, userInfo: [NSLocalizedDescriptionKey: "Speech recognition is not available"])
        }
        
        // 既存のタスクをキャンセルしてクリア
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        // オーディオセッションの設定
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        
        // 音声認識のリクエストを作成
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else {
            throw NSError(domain: "SpeechRecognizer", code: 2, userInfo: [NSLocalizedDescriptionKey: "Unable to create a recognition request"])
        }
        recognitionRequest.shouldReportPartialResults = true
        
        // オーディオ入力を設定
        let inputNode = audioEngine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, when in
            recognitionRequest.append(buffer)
        }
        
        // オーディオエンジンを起動
        audioEngine.prepare()
        try audioEngine.start()
        
        // 音声認識を実行
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
            if let result = result {
                completion(result.bestTranscription.formattedString)
            }
            
            if error != nil || (result?.isFinal ?? false) {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                self.recognitionRequest = nil
                self.recognitionTask = nil
            }
        }
    }
    
    // 音声認識を停止
    func stopRecognition() {
        audioEngine.stop()
        recognitionRequest?.endAudio()
        recognitionTask?.cancel()
    }
}

