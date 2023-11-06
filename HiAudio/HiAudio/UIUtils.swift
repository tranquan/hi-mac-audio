//
//  Utils.swift
//  HiAudio
//
//  Created by Kenji on 2023-11-06.
//

import Foundation
import SwiftUI

struct UIUtils {
	static func showAlert(_ title: String, description: String = "") {
		let alert = NSAlert()
		alert.messageText = title
		alert.informativeText = description
		alert.alertStyle = .informational
		alert.addButton(withTitle: "Close")
		alert.runModal()
	}

	static func showYesNoAlert(
		title: String,
		description: String,
		yesTitle: String,
		yesAction: () -> Void,
		noTitle: String,
		noAction: () -> Void
	) {
		let alert = NSAlert()
		alert.messageText = title
		alert.informativeText = "description"
		alert.alertStyle = .informational
		alert.addButton(withTitle: "Close")
		alert.runModal()
	}
}
