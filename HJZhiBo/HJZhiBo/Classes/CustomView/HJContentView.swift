//
//  HJContentView.swift
//  HJZhiBo
//
//  Created by lulu on 2018/8/15.
//  Copyright © 2018年 Jermy. All rights reserved.
//

import UIKit

let contentViewCellID = "contentViewCellID"

class HJContentView: UIView {

    private var subViewControllers: [UIViewController] = [UIViewController]()
    private var parentViewController: UIViewController = UIViewController()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = bounds.size
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentViewCellID)
        collectionView.isPagingEnabled = true
        collectionView.frame = self.bounds
        return collectionView
    }()
    
    init(frame: CGRect, subViewControllers: [UIViewController], parentViewController: UIViewController) {
        super.init(frame: frame)
        self.subViewControllers = subViewControllers
        self.parentViewController = parentViewController
        
        setupViewControllers()
        setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HJContentView {
    
    private func setupViewControllers() {
        for viewController in subViewControllers {
            parentViewController.addChildViewController(viewController)
        }
    }
    
    private func setupCollectionView() {
        self.addSubview(collectionView)
    }
}

extension HJContentView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subViewControllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentViewCellID, for: indexPath)
        
        let viewController = subViewControllers[indexPath.item]
        viewController.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(viewController.view)
        return cell
    }
}
