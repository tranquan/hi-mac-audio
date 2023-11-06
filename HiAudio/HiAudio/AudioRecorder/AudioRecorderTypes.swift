//
//  AudioRecorderTypes.swift
//  HiAudio
//
//  Created by Kenji on 2023-11-03.
//

import Foundation

enum RecordingState {
	case recording
	case paused
	case stopped
}

enum AudioRecorderError: Error {
	case general(_ message: String)
}

protocol IAudioRecorder {
	func startRecording() async throws -> Void
	func stopRecording() -> Void
}
