//
//  HJPageView.swift
//  HJZhiBo
//
//  Created by lulu on 2018/8/15.
//  Copyright © 2018年 Jermy. All rights reserved.
//

import UIKit

class HJPageView: UIView {
    
    private var titles: [String] = [String]()
    private var subViewControllers: [UIViewController] = [UIViewController]()
    private var parentViewController: UIViewController = UIViewController()
    
    private lazy var conetntView : HJContentView = {
        let contentViewFrame = CGRect(x: 0, y: 40, width: frame.size.width, height: frame.size.height - 40)
        let _contentView = HJContentView(frame: contentViewFrame, subViewControllers: subViewControllers, parentViewController: parentViewController)
        _contentView.delegate = self
        return _contentView
    }()
    
    private lazy var titleView : HJTitleView = {
        let titleFrame = CGRect(x: 0, y: 0, width: frame.size.width, height: 40)
        let style = HJTitleViewStyle()
        style.isScrollEnable = true
        style.titleColor = .green
        style.titleSelecteColor = .red
        let titleView = HJTitleView(frame: titleFrame, titles: titles, style: style)
        titleView.delegate = self
        return titleView
    }()
    
    init(frame: CGRect, titles: [String], subViewControllers: [UIViewController], parentViewController: UIViewController) {
        super.init(frame: frame)
        self.titles = titles
        self.subViewControllers = subViewControllers
        self.parentViewController = parentViewController
        parentViewController.automaticallyAdjustsScrollViewInsets = false
        setupTitleView()
        setupContentView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HJPageView {
    
    func setupTitleView() {
        
        self.addSubview(titleView)
    }
    
    func setupContentView() {
        
        self.addSubview(conetntView)
    }
}

extension HJPageView : HJTitleViewDelegate{
    func titleViewDidScrolled(index: Int) {
        self.conetntView.contentViewScrollToIndex(index: index)
    }
}

extension HJPageView : HJContentViewDelegate {
    func contentViewDidScrollToIndex(index: Int) {
        self.titleView.titleViewScrollToIndex(index: index)
    }
}
