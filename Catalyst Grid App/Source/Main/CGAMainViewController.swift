//
//  CGAMainViewController.swift
//  Catalyst Grid App
//
//  Created by Steven Troughton-Smith on 07/10/2021.
//  
//

import UIKit

final class CGAMainViewController: UIViewController, UINavigationControllerDelegate {
	
	let gridVC = CGAGridViewController()
	let inspectorVC = CGAInspectorViewController()
	var gridNC:UINavigationController!
	
	var sceneDelegate:CGASceneDelegate?
	
    init() {
        super.init(nibName: nil, bundle: nil)
       
		gridNC = UINavigationController(rootViewController: gridVC)
		
		gridNC.delegate = self
		
		#if targetEnvironment(macCatalyst)
		gridNC.isNavigationBarHidden = true
		#endif
		
		addChild(gridNC)
		addChild(inspectorVC)
		
		view.addSubview(gridNC.view)
		view.addSubview(inspectorVC.view)
	}

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
	
	// MARK: Responder Chain -
	
	override var canBecomeFirstResponder: Bool {
		return true
	}
	
	override func responds(to aSelector: Selector!) -> Bool {
		
		/*
		 This is the magic that determines whether the back button is enabled/disabled
		 */
		
		if aSelector == #selector(goBack(_:)) {
			return (gridNC.viewControllers.count > 1) ? true : false
		}
		
		return super.responds(to: aSelector)
	}
	
	@objc func goBack(_ sender:Any) {
		gridNC.popViewController(animated: true)
	}
	
	// MARK: Layout -
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		var inspectorWidth = UIFloat(260)
		
		/* Hide the inspector sidebar if the view gets too small */
		if view.bounds.width < (inspectorWidth*2) {
			inspectorWidth = 0
		}
		
		let division = view.bounds.divided(atDistance: inspectorWidth, from: .maxXEdge)
		
		inspectorVC.view.frame = division.slice
		gridNC.view.frame = division.remainder
	}
	
	// MARK: Navigation (macOS) -

	/* On macOS, change the window title to match the navigation controller's current item */
	func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
		#if targetEnvironment(macCatalyst)
		guard let sceneDelegate = sceneDelegate else { return }
		
		sceneDelegate.window?.windowScene?.title = viewController.title
		
		#endif
	}
}
