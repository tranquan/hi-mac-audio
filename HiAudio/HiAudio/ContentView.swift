//
//  ContentView.swift
//  HiAudio
//
//  Created by Kenji on 2023-11-03.
//

import SwiftUI

struct ContentView: View {
	@ObservedObject var recorder = AudioRecordingManager.shared

	var durationText: String {
		let duration = recorder.recordingDuration
		let durationText = duration > 0 ? String(format: " %02d:%02d", duration / 60, duration % 60) : "00:00"

		return durationText
	}

	var body: some View {
		VStack {
			HStack {
				Text(durationText)
				Button("Record") {
					self.startRecording()
				}
			}
			.frame(maxWidth: .infinity, alignment: .leading)
			.border(.green)
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
		.padding()
	}

	func startRecording() {
		Task { @MainActor in
			do {
				try await recorder.startRecording()
			} catch {
				UIUtils.showAlert("Error", description: error.localizedDescription)
			}
		}
	}

	func stopRecording() {
		Task { @MainActor in
			do {
				try await recorder.stopRecording()
			} catch {
				UIUtils.showAlert("Error", description: error.localizedDescription)
			}
		}
	}
}

#Preview {
	ContentView()
		.frame(width: 480, height: 360)
}
