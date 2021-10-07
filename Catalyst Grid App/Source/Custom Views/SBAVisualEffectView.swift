//
//  MRDVisualEffectView.swift
//  MobileRadio
//
//  Created by Steven Troughton-Smith on 13/09/2020.
//  Copyright © 2020 High Caffeine Content. All rights reserved.
//

import UIKit

class SBAVisualEffectView: UIVisualEffectView {
	
	let contentEffectView:UIVisualEffectView
	
	init(blurStyle: UIBlurEffect.Style) {
		let blurEffect = UIBlurEffect(style: blurStyle)
		let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)

		contentEffectView = UIVisualEffectView(effect: vibrancyEffect)
		super.init(effect: blurEffect)
		
		contentView.addSubview(contentEffectView)
	}
	
	init(blurStyle: UIBlurEffect.Style, blur2Style: UIBlurEffect.Style) {
		let blurEffect = UIBlurEffect(style: blurStyle)
		let blur2Effect = UIBlurEffect(style: blur2Style)
		let vibrancyEffect = UIVibrancyEffect(blurEffect: blur2Effect)

		contentEffectView = UIVisualEffectView(effect: vibrancyEffect)
		super.init(effect: blurEffect)
		
		contentView.addSubview(contentEffectView)
	}
	
	init()
	{
		contentEffectView = UIVisualEffectView(effect: nil)
		super.init(effect: nil)
		contentView.addSubview(contentEffectView)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	@objc func addContentView(_ view: UIView) {
		contentEffectView.contentView.addSubview(view)
	}
	
	override func layoutSubviews() {
		contentEffectView.frame = bounds
	}
}
