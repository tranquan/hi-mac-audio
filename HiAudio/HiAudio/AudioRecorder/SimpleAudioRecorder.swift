//
//  SimpleRecorder.swift
//  HiAudio
//
//  Created by Kenji on 2023-11-03.
//
// 	A simple audio recorder that used AVAudioRecorder

import AVFoundation
import Foundation

private struct AudioRecorderOption {
	let fileExtension: String
	let recorderSettings: [String: Any]
}

private enum AllAudioRecorderOptions {
	static let aac = AudioRecorderOption(
		fileExtension: "m4a",
		recorderSettings: [
			AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
			AVSampleRateKey: 44_100,
			AVEncoderBitRateKey: 32_000,
			AVNumberOfChannelsKey: 1,
			AVEncoderAudioQualityKey: AVAudioQuality.medium.rawValue
		]
	)
	static let opus = AudioRecorderOption(
		fileExtension: "opus",
		recorderSettings: [
			AVFormatIDKey: Int(kAudioFormatOpus),
			AVSampleRateKey: 48_000,
			AVEncoderBitRateKey: 24_000,
			AVNumberOfChannelsKey: 1,
			AVEncoderAudioQualityKey: AVAudioQuality.medium.rawValue
		]
	)
	static let linearPCM = AudioRecorderOption(
		fileExtension: "wav",
		recorderSettings: [
			AVFormatIDKey: Int(kAudioFormatLinearPCM),
			AVSampleRateKey: 44_100,
			AVEncoderBitRateKey: 32_000,
			AVNumberOfChannelsKey: 1,
			AVEncoderAudioQualityKey: AVAudioQuality.medium.rawValue
		]
	)
}

// MARK: - SimpleAudioRecorder

class SimpleAudioRecorder: NSObject, IAudioRecorder {
	private var audioRecorder: AVAudioRecorder!

	private var durationTimer: Timer?
	private(set) var recordingState: RecordingState = .stopped

	private let TAG = "\(SimpleAudioRecorder.self)"

	func startRecording() async throws {
		do {
			let option = AllAudioRecorderOptions.aac
			let recordingUrl = RecorderUtil.genNewRecordingFileUrl(fileExtension: option.fileExtension)

			let audioRecorder = try AVAudioRecorder(url: recordingUrl, settings: option.recorderSettings)
			audioRecorder.delegate = self

			if !audioRecorder.prepareToRecord() {
				throw AudioRecorderError.general("prepareToRecord failed")
			}
			if !audioRecorder.record() {
				throw AudioRecorderError.general("record fail")
			}

			self.audioRecorder = audioRecorder
		} catch {
			print("startRecording error: \(error.localizedDescription)")
			throw error
		}
	}

	func stopRecording() {
		self.audioRecorder.stop()
//		SubscriptionManager.shared.onRecordedAudio(durationSeconds: recordingDuration)
//
//		audioRecorder?.stop()
//
//		recordingState = .stopped
//		recordingDuration = 0
//		cleanUpAfterStoppingOrPausingRecording()
	}
}

// MARK: - AVAudioRecorderDelegate

extension SimpleAudioRecorder: AVAudioRecorderDelegate {
	func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
//		do {
//			if !flag {
//				throw AppError.general("failed to record, flag: \(flag)")
//			}
//
//			guard let fileUrl = audioFileUrl else {
//				throw AppError.general("audio file is nil")
//			}
//
//			handleFinishRecording(fileUrl: fileUrl)
//		} catch let error as AppError {
//			DispatchQueue.main.async {
//				self.delegate?.recorderDidStopRecording(recorder: self, error: error)
//			}
//		} catch {
//			DispatchQueue.main.async {
//				self.delegate?.recorderDidStopRecording(recorder: self, error: AppError.fromError(error))
//			}
//		}
	}

	func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
		print("\(description): audioRecorderEncodeErrorDidOccur: \(error.debugDescription)")
	}
}
