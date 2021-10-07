//
//  CGAInspectorViewController.swift
//  CGAInspectorViewController
//
//  Created by Steven Troughton-Smith on 09/09/2021.
//

import UIKit
import SwiftUI


struct HIBorderedTextFieldView: UIViewRepresentable {
	typealias UIViewType = UITextField
	let view = UITextField()
	
	var placeholder = ""
	var borderStyle = UITextField.BorderStyle.none
	
	func makeUIView(context: Context) -> UIViewType {
		return view
	}
	
	func updateUIView(_ uiView: UIViewType, context: Context) {
		view.placeholder = NSLocalizedString(placeholder, comment: "")
		view.borderStyle = borderStyle
		
		view.setContentHuggingPriority(.required, for: .vertical)
	}
}

struct Swatch: View {
	let color: Color
	
	var body: some View {
		Circle()
			.fill(color)
			.frame(width: UIFloat(20), height: UIFloat(20))
	}
}

struct ContentView: View {
	
	@State var a = true
	@State var b = false
	@State var c = false
	@State var d = 75.0
	
	var body: some View {
		ScrollView {
			VStack(alignment:.leading) {
				Text("INSPECTOR_SECTION_ITEM")
					.font(.system(size: UIFloat(16), weight: .bold, design: .default))
					.foregroundColor(.secondary)
					.frame(maxWidth:.infinity, alignment: .leading)
				
				HStack {
					Text("INSPECTOR_SECTION_ITEM_NAME")
						.font(.caption)
					
					HIBorderedTextFieldView(placeholder:"INSPECTOR_SECTION_ITEM_NAME_PLACEHOLDER", borderStyle: supportsMacIdiom ? .bezel : .roundedRect)
						.frame(maxWidth:.infinity)
				}
				
				Group {
					Divider()
						.padding(.vertical, UIFloat(13))
					
					Text("INSPECTOR_SECTION_SOUND")
						.font(.system(size: UIFloat(16), weight: .bold, design: .default))
						.foregroundColor(.secondary)
						.frame(maxWidth:.infinity, alignment: .leading)
					
					
					HStack {
						Slider(value: $d, in: 0 ... 100, minimumValueLabel: Image(systemName:"speaker.wave.3.fill"), maximumValueLabel: nil, label: {
							Text("Volume")
						})
							.font(.caption)
							.foregroundColor(.secondary)
						
						Text(String(format:"%.0f%%", d))
							.font(.caption)
							.frame(width: UIFloat(35), alignment: .trailing)
					}
					
					VStack(alignment:.leading) {
						Toggle("INSPECTOR_SECTION_SETTINGS_FADEIN", isOn: $c)
						Toggle("INSPECTOR_SECTION_SETTINGS_FADEOUT", isOn: $c)
					}
					.font(.caption)
				}
				
				Divider()
					.padding(.vertical, UIFloat(13))
				
				Text("INSPECTOR_SECTION_SETTINGS")
					.font(.system(size: UIFloat(16), weight: .bold, design: .default))
					.foregroundColor(.secondary)
					.frame(maxWidth:.infinity, alignment: .leading)
				
				VStack(alignment:.leading) {
					Toggle("INSPECTOR_SECTION_SETTINGS_LOOP", isOn: $a)
					Toggle("INSPECTOR_SECTION_SETTINGS_SOLO", isOn: $b)
					
				}
				.font(.caption)
				
				Divider()
					.padding(.vertical, UIFloat(13))
				
				Text("INSPECTOR_SECTION_COLOR")
					.font(.system(size: UIFloat(16), weight: .bold, design: .default))
					.foregroundColor(.secondary)
					.frame(maxWidth:.infinity, alignment: .leading)
				
				HStack {
					Swatch(color:.red)
					Swatch(color:.green)
					Swatch(color:.blue)
					Swatch(color:.purple)
					Swatch(color:.orange)
					Swatch(color:.gray)
				}
				
				Spacer(minLength: 0)
				
			}
			.frame(maxWidth:.infinity, maxHeight: .infinity)
			.padding(UIFloat(13))
		}
	}
}

class CGAInspectorViewController: UIViewController {
	let hostingController = UIHostingController(rootView: ContentView())
	
	override func loadView() {
		let view = SBAVisualEffectView(blurStyle: .systemChromeMaterial)
		
#if !targetEnvironment(macCatalyst)
		view.contentView.backgroundColor = .systemGroupedBackground
#endif
		
		let dividerView = SBAHairlineDividerView()
		dividerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
		dividerView.dividerColor = .separator
		dividerView.borderMask = .left
		dividerView.backgroundColor = .clear
		
		view.contentView.addSubview(dividerView)
		
		hostingController.view.backgroundColor = .clear
		view.contentView.addSubview(hostingController.view)
		
		self.view = view
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		hostingController.view.frame = view.bounds.inset(by: view.safeAreaInsets)
	}
}
