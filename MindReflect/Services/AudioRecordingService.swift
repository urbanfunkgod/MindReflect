//
//  AudioRecordingService.swift
//  MindReflect
//
//  Created by Johann Flores on 5/13/25.
//
import AVFoundation

class AudioRecordingService: NSObject, ObservableObject {
    private var audioRecorder: AVAudioRecorder?
    @Published var isRecording = false
    
    override init() {
        super.init()
    }
    
    private func setupAudioSession() {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(.record, mode: .default, options: [])
            try session.setActive(true)
            print("Audio session set up successfully")
        } catch {
            print("Failed to set up audio session: \(error)")
        }
    }
    
    func requestMicrophonePermission(completion: @escaping (Bool) -> Void) {
        AVAudioApplication.requestRecordPermission { granted in
            DispatchQueue.main.async {
                print("Microphone permission granted: \(granted)")
                completion(granted)
            }
        }
    }
    
    func startRecording() {
        requestMicrophonePermission { [weak self] granted in
            guard let self = self else { return }
            if !granted {
                print("Microphone permission denied")
                self.isRecording = false
                return
            }
            
            self.setupAudioSession()
            
            let settings: [String: Any] = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 44100.0,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            do {
                let url = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString + ".m4a")
                print("Recording to URL: \(url.absoluteString)")
                self.audioRecorder = try AVAudioRecorder(url: url, settings: settings)
                self.audioRecorder?.delegate = self
                let success = self.audioRecorder?.record() ?? false
                if success {
                    print("Recording started successfully")
                    self.isRecording = true
                } else {
                    print("Failed to start recording: Recorder returned false")
                    self.isRecording = false
                }
            } catch {
                print("Recording failed: \(error)")
                self.isRecording = false
            }
        }
    }
    
    func stopRecording() -> URL? {
        audioRecorder?.stop()
        isRecording = false
        let url = audioRecorder?.url
        print("Recording stopped. URL: \(url?.absoluteString ?? "nil")")
        return url
    }
}

extension AudioRecordingService: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            print("Recording did not finish successfully")
            isRecording = false
        }
    }
    
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        print("Recording error: \(error?.localizedDescription ?? "Unknown error")")
        isRecording = false
    }
}
