//
//  CGAGridViewController.swift
//  Catalyst Grid App
//
//  Created by Steven Troughton-Smith on 07/10/2021.
//

import UIKit

class CGAGridViewController: UICollectionViewController {
	
	let reuseIdentifier = "Cell"
	let padding = UIFloat(13)
	
	enum HIGridSection {
		case main
	}
	
	struct HIGridItem: Hashable {
		var title: String = ""
		
		func hash(into hasher: inout Hasher) {
			hasher.combine(identifier)
		}
		static func == (lhs: HIGridItem, rhs: HIGridItem) -> Bool {
			return lhs.identifier == rhs.identifier
		}
		private let identifier = UUID()
	}
	
	var dataSource: UICollectionViewDiffableDataSource<HIGridSection, HIGridItem>! = nil
	
	init() {
		let layout = UICollectionViewFlowLayout()
		
		super.init(collectionViewLayout: layout)
		
		guard let collectionView = collectionView else { return }
		
		title = "Root"
				
		collectionView.backgroundColor = .systemBackground
		collectionView.contentInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
		collectionView.register(CGAGridViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
		
		configureDataSource()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: Data Source -
	
	func configureDataSource() {
		
		dataSource = UICollectionViewDiffableDataSource<HIGridSection, HIGridItem>(collectionView: collectionView) {
			(collectionView: UICollectionView, indexPath: IndexPath, item: HIGridItem) -> UICollectionViewCell? in
			
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifier, for: indexPath)
			
			/*
			 Customize cell here
			 */
			
			return cell
		}
		
		collectionView.dataSource = dataSource
		
		refresh()
	}
	
	
	func initialSnapshot() -> NSDiffableDataSourceSectionSnapshot<HIGridItem> {
		var snapshot = NSDiffableDataSourceSectionSnapshot<HIGridItem>()
		
		/* Just some dummy items to populate the grid */
		for _ in 0 ..< 10 {
			let items = [HIGridItem()]
			snapshot.append(items)
		}
		
		return snapshot
	}
	
	func refresh() {
		guard let dataSource = collectionView.dataSource as? UICollectionViewDiffableDataSource<HIGridSection, HIGridItem> else { return }
		
		dataSource.apply(initialSnapshot(), to: .main, animatingDifferences: false)
	}
	
	// MARK: Manual Layout Sizing (Fast) -
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		var columns = 4
		let threshold = UIFloat(200)
				
		guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
		
		while view.bounds.size.width/CGFloat(columns) > threshold
		{
			columns += 1
		}
		
		let frame = view.bounds.inset(by: collectionView.contentInset)
		
		let itemSize = (frame.width - padding*CGFloat(columns-1)) / CGFloat(columns)
		
		layout.itemSize = CGSize(width: itemSize, height: itemSize)
		layout.minimumLineSpacing = padding
		layout.minimumInteritemSpacing = 0
	}
	
	// MARK: -

	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		let vc = CGAGridViewController()
		vc.title = "Child"
		
		navigationController?.pushViewController(vc, animated: true)
		
		
	}
}
