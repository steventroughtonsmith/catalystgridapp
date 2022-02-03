//
//  CGASceneDelegate.swift
//  Catalyst Grid App
//
//  Created by Steven Troughton-Smith on 07/10/2021.
//  
//

import UIKit

class CGASceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?
	let mainVC = CGAMainViewController()

	func buildPrimaryUI() {
		
		guard let window = window, let windowScene = window.windowScene else { return }

		let svc = UISplitViewController(style: .doubleColumn)
		
		let sidebarVC = CGASidebarSourceListViewController()
		mainVC.sceneDelegate = self
		
		svc.viewControllers = [sidebarVC, mainVC]
		svc.primaryBackgroundStyle = .sidebar
		
		window.rootViewController = svc
		
#if targetEnvironment(macCatalyst)
		
		svc.preferredPrimaryColumnWidth = UIFloat(260)
		
		sidebarVC.navigationController?.isNavigationBarHidden = true
		mainVC.navigationController?.isNavigationBarHidden = true
		
		let toolbar = NSToolbar(identifier: NSToolbar.Identifier("CGASceneDelegate.Toolbar"))
		toolbar.delegate = self
		toolbar.displayMode = .iconOnly
		toolbar.allowsUserCustomization = false
		
		windowScene.titlebar?.toolbar = toolbar
		windowScene.titlebar?.toolbarStyle = .unified
		
#endif
	}
	
	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = scene as? UIWindowScene else {
			fatalError("Expected scene of type UIWindowScene but got an unexpected type")
		}
		window = UIWindow(windowScene: windowScene)
		
		if let window = window {
			
			buildPrimaryUI()
			window.makeKeyAndVisible()
		}
	}
}
