//
//  CGAGridViewCell.swift
//  Catalyst Grid App
//
//  Created by Steven Troughton-Smith on 07/10/2021.
//

import UIKit

class CGAGridViewCell: UICollectionViewCell {
	
	/*
	 Custom subviews go here, add to the content view, then lay them out in layoutSubviews
	 */
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		contentView.backgroundColor = .systemFill
		
		contentView.layer.cornerCurve = .continuous
		contentView.layer.cornerRadius = UIFloat(8)
		
		contentView.layer.borderWidth = UIFloat(0.5)
		contentView.layer.borderColor = UIColor.separator.cgColor
		
		layer.shadowRadius = UIFloat(2)
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOpacity = 0.3
		layer.shadowOffset = CGSize(width: 0, height: UIFloat(1))
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews() // Always call super
		
		
	}
}
