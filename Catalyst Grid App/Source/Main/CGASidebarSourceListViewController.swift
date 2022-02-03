//
//  CGASidebarSourceListViewController.swift
//  CGASidebarSourceListViewController
//
//  Created by Steven Troughton-Smith on 14/09/2021.
//

import UIKit

class CGASidebarSourceListViewController: UICollectionViewController {
	
	enum HIOutlineSection {
		case favorites
		case folders
	}
	
	struct HIOutlineItem: Hashable {
		var title: String = ""
		var indentation = 0
		var subitems: [HIOutlineItem] = []
		
		func hash(into hasher: inout Hasher) {
			hasher.combine(identifier)
		}
		static func == (lhs: HIOutlineItem, rhs: HIOutlineItem) -> Bool {
			return lhs.identifier == rhs.identifier
		}
		private let identifier = UUID()
	}
	
	var dataSource: UICollectionViewDiffableDataSource<HIOutlineSection, HIOutlineItem>! = nil
	
	init() {
		var listConfiguration = UICollectionLayoutListConfiguration(appearance: .sidebar)
		listConfiguration.showsSeparators = false
		
		let layout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
		
		super.init(collectionViewLayout: layout)
				
		configureDataSource()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: Data Source -
	
	func configureDataSource() {
		
		let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, HIOutlineItem> { cell, indexPath, menuItem in
			
			var contentConfiguration = cell.defaultContentConfiguration()
			var disclosureOptions = UICellAccessory.OutlineDisclosureOptions(style: .cell)

			if indexPath.item == 0 {
				disclosureOptions = UICellAccessory.OutlineDisclosureOptions(style: .header)
				contentConfiguration = UIListContentConfiguration.sidebarHeader()
			}
			else {
				contentConfiguration.textProperties.font = .preferredFont(forTextStyle: .body)
				contentConfiguration.imageProperties.reservedLayoutSize = CGSize(width: UIFloat(22), height: 0)
			}
			
			if indexPath.section == 0 {
				if indexPath.row == 1 {
					contentConfiguration.image = UIImage(systemName: "tray")
				}
				else if indexPath.row == 2 {
					contentConfiguration.image = UIImage(systemName: "clock")
				}
			}
			else {
				if indexPath.row > 0 {
					contentConfiguration.image = UIImage(systemName: "folder")
				}
			}
		
			contentConfiguration.text = menuItem.title
			
			if indexPath.section == 1 {

				if menuItem.subitems.isEmpty == true {
					disclosureOptions.isHidden = true
				}
				else {
					disclosureOptions.isHidden = false
				}
				cell.accessories = [.outlineDisclosure(options: disclosureOptions)]
				
				cell.indentationLevel = menuItem.indentation
			}
			
			cell.contentConfiguration = contentConfiguration
		}
		
		dataSource = UICollectionViewDiffableDataSource<HIOutlineSection, HIOutlineItem>(collectionView: collectionView) {
			(collectionView: UICollectionView, indexPath: IndexPath, item: HIOutlineItem) -> UICollectionViewCell? in
		
			return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
		}
		
		collectionView.dataSource = dataSource
		
		refresh()
	}

	// MARK: -
	
	private lazy var menuItems: [HIOutlineItem] = {
		return [
		
			HIOutlineItem(title: "Folders", subitems: [
				HIOutlineItem(title: "Folder A", indentation: 0),
				HIOutlineItem(title: "Folder B", indentation: 0, subitems: [HIOutlineItem(title: "Folder C", indentation: 1, subitems: [])])
														   ])

		]
	}()
	
	private lazy var favoriteItems: [HIOutlineItem] = {
		return [
			HIOutlineItem(title: "Favorites", subitems: [
				HIOutlineItem(title: "All"),
				HIOutlineItem(title: "Recents")
			]),

		]
	}()
	
	func initialSnapshot(forItems:[HIOutlineItem]) -> NSDiffableDataSourceSectionSnapshot<HIOutlineItem> {
		var snapshot = NSDiffableDataSourceSectionSnapshot<HIOutlineItem>()
				
		func addItems(_ menuItems: [HIOutlineItem], to parent: HIOutlineItem?) {
			snapshot.append(menuItems, to: parent)
			snapshot.expand(menuItems)
			for menuItem in menuItems where !menuItem.subitems.isEmpty {
				addItems(menuItem.subitems, to: menuItem)
			}
		}
		
		addItems(forItems, to: nil)
		
		return snapshot
	}
	
	func refresh() {
		guard let dataSource = collectionView.dataSource as? UICollectionViewDiffableDataSource<HIOutlineSection, HIOutlineItem> else { return }
		
		dataSource.apply(initialSnapshot(forItems: favoriteItems), to: .favorites, animatingDifferences: false)
		dataSource.apply(initialSnapshot(forItems: menuItems), to: .folders, animatingDifferences: false)
		
		DispatchQueue.main.async {
			self.collectionView.selectItem(at: IndexPath(item: 1, section: 0), animated: false, scrollPosition: [])
		}
	}
	
	// MARK: - Focus Support
	
	override func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {

		/* Don't focus the favorites group header */
		if indexPath.section == 0 && indexPath.row == 0 {
			return false
		}
		
		return true
	}
}
