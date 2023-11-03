//
//  ContentView.swift
//  HiAudio
//
//  Created by Kenji on 2023-11-03.
//

import SwiftUI

struct ContentView: View {
	var body: some View {
		VStack {
			HStack {
				Text("00:00")
				Button("Record") {
					// TODO: record
				}
			}
			.frame(maxWidth: .infinity, alignment: .leading)
			.border(.green)
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
		.padding()
	}
}

#Preview {
	ContentView()
		.frame(width: 480, height: 360)
}
