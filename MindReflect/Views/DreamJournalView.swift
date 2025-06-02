//
//  DreamJournalView.swift
//  MindReflect
//
//  Created by Johann Flores on 5/13/25.
//
import SwiftUI
import AVFoundation

struct DreamJournalView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var audioRecorder = AudioRecordingService()
    @State private var dreamDescription = ""
    @State private var emotions = ""
    @State private var recordedAudioURL: URL? // Store the recorded audio URL
    
    let journalViewModel: JournalViewModel
    
    var body: some View {
        Form {
            Section(header: Text("Dream Description")
                .foregroundColor(Color("TextPrimary"))) {
                TextEditor(text: $dreamDescription)
                    .font(.custom("SFProText-Regular", size: 16))
                    .foregroundColor(Color("TextPrimary"))
                    .frame(minHeight: 100)
                    .accessibilityLabel("Dream description")
            }
            
            Section(header: Text("Associated Emotions")
                .foregroundColor(Color("TextPrimary"))) {
                TextField("Emotions felt (e.g., scared, happy)", text: $emotions)
                    .font(.custom("SFProText-Regular", size: 16))
                    .foregroundColor(Color("TextPrimary"))
                    .accessibilityLabel("Associated emotions")
            }
            
            // Audio Recording Button
            Section {
                Button(action: {
                    if audioRecorder.isRecording {
                        recordedAudioURL = audioRecorder.stopRecording()
                    } else {
                        audioRecorder.startRecording()
                    }
                }) {
                    Text(audioRecorder.isRecording ? "Stop Recording" : "Record Audio")
                        .font(.custom("SFProText-Medium", size: 16))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(audioRecorder.isRecording ? Color("ErrorRed") : Color("SecondaryWarm"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            
            // Display Recorded Audio URL (for now, as a placeholder)
            if let url = recordedAudioURL {
                Section {
                    Text("Recorded Audio: \(url.lastPathComponent)")
                        .font(.custom("SFProText-Regular", size: 14))
                        .foregroundColor(Color("TextSecondary"))
                        .padding(.top, 8)
                }
            }
            
            Section {
                Button(action: {
                    // Combine text content and audio URL (if any) into the dream entry
                    var content = "Dream: \(dreamDescription)\nEmotions: \(emotions)"
                    if let audioURL = recordedAudioURL {
                        content += "\n[Audio Recording: \(audioURL.lastPathComponent)]"
                    }
                    journalViewModel.saveEntry(content: content, type: .dream, tags: ["dream"])
                    dismiss()
                }) {
                    Text("Save Dream")
                        .font(.custom("SFProText-Medium", size: 16))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("PrimaryBlue"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
        .navigationTitle("Dream Journal")
        .background(Color.white)
    }
}

struct DreamJournalView_Previews: PreviewProvider {
    static var previews: some View {
        DreamJournalView(journalViewModel: JournalViewModel())
    }
}
