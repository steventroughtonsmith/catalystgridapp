//
//  CGAAppDelegate+NSToolbar.swift
//  Catalyst Grid App
//
//  Created by Steven Troughton-Smith on 07/10/2021.
//  
//

import UIKit

extension CGAAppDelegate {
	
	override func buildMenu(with builder: UIMenuBuilder) {
		if builder.system == UIMenuSystem.context {
			return
		}
		
		super.buildMenu(with: builder)
		
		builder.remove(menu: .format)
		builder.remove(menu: .toolbar)
		builder.remove(menu: .newScene)
		
		/* Add 'Back' option to View menu */
		do {
			let command = UIKeyCommand(input: "[", modifierFlags: [.command], action: NSSelectorFromString("goBack:"))
			command.title = NSLocalizedString("MENU_VIEW_GO_BACK", comment: "")
			command.discoverabilityTitle = NSLocalizedString("MENU_VIEW_GO_BACK", comment: "")
			
			let menu = UIMenu(identifier: UIMenu.Identifier("GoBack"), options: .displayInline, children: [command])
			
			builder.insertChild(menu, atStartOfMenu: .view)
		}
	}
	
}
