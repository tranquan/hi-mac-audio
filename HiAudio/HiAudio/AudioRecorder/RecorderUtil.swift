//
//  Utils.swift
//  HiAudio
//
//  Created by Kenji on 2023-11-03.
//

import Foundation

struct RecorderUtil {
	static func getRecodingDirectory() -> URL {
		let doc = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
		let dir = doc.appendingPathComponent("audio")
		var isDir = ObjCBool(false)
		let isExist = FileManager.default.fileExists(atPath: dir.path, isDirectory: &isDir)
		if !isExist || !isDir.boolValue {
			try! FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
		}
		return dir
	}

	static func genNewRecordingFileUrl(fileExtension: String) -> URL {
		let document = getRecodingDirectory()
		let time = Int(Date().timeIntervalSince1970)
		return document.appendingPathComponent("\(time).\(fileExtension)")
	}
}
