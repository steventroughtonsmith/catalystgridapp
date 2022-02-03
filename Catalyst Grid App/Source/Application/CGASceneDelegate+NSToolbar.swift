//
//  CGASceneDelegate+NSToolbar.swift
//  Catalyst Grid App
//
//  Created by Steven Troughton-Smith on 07/10/2021.
//  
//

import UIKit

#if targetEnvironment(macCatalyst)
import AppKit

extension NSToolbarItem.Identifier {
	static let back = NSToolbarItem.Identifier("com.example.back")
}

extension CGASceneDelegate: NSToolbarDelegate {
    
	func toolbarItems() -> [NSToolbarItem.Identifier] {
		return [.back]
	}
	
	func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
		return toolbarItems()
	}
	
	func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
		return toolbarItems()
	}
	
	func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
		if itemIdentifier == .back {
			
			let barItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: mainVC, action: NSSelectorFromString("goBack:"))
			/*
			 NSToolbarItemGroup does not auto-enable/disable buttons based on the responder chain, so we need an NSToolbarItem here instead
			 */
			
			let item = NSToolbarItem(itemIdentifier: itemIdentifier, barButtonItem: barItem)
			
			item.label = NSLocalizedString("BACK", comment: "")
			item.toolTip = NSLocalizedString("BACK", comment: "")
			item.isBordered = true
			item.isNavigational = true
			
			return item
		}
		
		return NSToolbarItem(itemIdentifier: itemIdentifier)
	}
}
#endif
