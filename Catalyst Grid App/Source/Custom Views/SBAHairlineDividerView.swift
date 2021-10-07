//
//  PSTLHairlineDividerView.swift
//  Pastel
//
//  Created by Steven Troughton-Smith on 31/08/2021.
//  Copyright © 2021 Steven Troughton-Smith. All rights reserved.
//

import UIKit

extension UIRectEdge {
	static let centeredVertically = UIRectEdge.init(rawValue:99)
	static let centeredHorizontally = UIRectEdge.init(rawValue:100)
}

class SBAHairlineDividerView: UIView {

	@objc var dividerColor = UIColor.clear {
		didSet {
			setNeedsDisplay()
		}
	}
	
	var borderMask:UIRectEdge = []
	
	override func draw(_ rect: CGRect) {
		let dividerWidth = UIFloat(1)
		
		if backgroundColor != nil && backgroundColor != .clear {
			backgroundColor?.set()
			UIRectFill(bounds)
		}
		
		if dividerColor != .clear {
			dividerColor.set()
			
			if borderMask.contains(.top) == true {
				UIRectFill(CGRect(x: 0, y: 0, width: bounds.width, height: dividerWidth))
			}
			
			if borderMask.contains(.left) == true {
				UIRectFill(CGRect(x: 0, y: 0, width: dividerWidth, height: bounds.height))
			}
			
			if borderMask.contains(.bottom) == true {
				UIRectFill(CGRect(x: 0, y: bounds.height-dividerWidth, width: bounds.width, height: dividerWidth))
			}
			
			if borderMask.contains(.right) == true {
				UIRectFill(CGRect(x: bounds.width-dividerWidth, y: 0, width: dividerWidth, height: bounds.height))
			}
			
			if borderMask.contains(.centeredVertically) == true {
				UIRectFill(CGRect(x: bounds.midX-dividerWidth, y: 0, width: dividerWidth, height: bounds.height))
			}
			
			if borderMask.contains(.centeredHorizontally) == true {
				UIRectFill(CGRect(x: 0, y: bounds.midY-dividerWidth, width: bounds.width, height: dividerWidth))
			}
		}
		
	}
   
}
