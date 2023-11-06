//
//  AudioRecordingManager.swift
//  HiAudio
//
//  Created by Kenji on 2023-11-03.
//

import Foundation

class AudioRecordingManager: NSObject, ObservableObject {
	static var shared = AudioRecordingManager(audioRecorder: SimpleAudioRecorder())
	
	private var audioRecorder: IAudioRecorder
	var recordingState: RecordingState = .stopped
	
	@Published var recordingDuration: Int = 0
	private var durationTimer: Timer?
	
	init(audioRecorder: IAudioRecorder) {
		self.audioRecorder = audioRecorder
	}
	
	func startRecording() async throws {
		try await self.audioRecorder.startRecording()
		
		DispatchQueue.main.async {
			self.recordingState = .recording
			self.recordingDuration = 0
			self.durationTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
				self.recordingDuration += 1
			}
		}
	}
	
	func stopRecording() async throws {
		self.audioRecorder.stopRecording()
			
		DispatchQueue.main.async {
			self.recordingState = .stopped
			self.recordingDuration = 0
			self.durationTimer?.invalidate()
		}
	}
}
