//
//  HomeViewController.swift
//  HJZhiBo
//
//  Created by Jermy on 2018/8/14.
//  Copyright © 2018年 Jermy. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    //测试数据
    private lazy var dataArray : [CGFloat] = {
        var array : [CGFloat] = [CGFloat]()
        for i in 0 ..< 50 {
            let height = arc4random() % 100 + 150
            array.append(CGFloat(height))
        }
        
        return array
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
    }
    
    func setupUI() {
        
        //左边按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named : "home-logo"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(leftItemClick))
        
        //右边按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named : "search_btn_follow"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(rightItemClick))
        
        //中间搜索框
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        searchBar.placeholder = "主播昵称/房间号/链接"
        navigationItem.titleView = searchBar
        searchBar.searchBarStyle = UISearchBarStyle.minimal
        let textField : UITextField = searchBar.value(forKey: "_searchField") as! UITextField
        textField.textColor = UIColor.white
        
        let pageViewFrame = CGRect(x: 0, y: 64, width: self.view.frame.width, height: self.view.frame.height - 64)
//        let titles = ["音乐", "电影", "电视剧", "专题"]
//        let titles = ["音乐音乐", "电影音乐音乐", "电视剧", "专题音乐", "音乐音乐", "电影音乐音乐", "电视剧", "专题音乐"]
        let titles = ["音乐音乐"]
        
//        let layout = UICollectionViewFlowLayout()
//        layout.minimumLineSpacing = 10
//        layout.minimumInteritemSpacing = 10
//        let itemW = (view.frame.width - CGFloat(30)) * 0.5
//        layout.itemSize = CGSize(width: itemW, height: CGFloat(arc4random_uniform(50) + 100))
//        layout.scrollDirection = .vertical
//        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10)
        
        let layout = HJWaterFallLayout()
        layout.delegate = self
        
        let liveVC = LiveCollectionViewController(collectionViewLayout: layout)
        
        let viewControllers = [liveVC]
        let pageView = HJPageView(frame: pageViewFrame, titles: titles, subViewControllers: viewControllers, parentViewController: self)
        self.view.addSubview(pageView)
    }
}

extension HomeViewController : HJWaterFallLayoutDelegate {
    func HJWaterFallLayoutHeightForItemAtIndexPath(indexPath: IndexPath) -> CGFloat {
        return dataArray[indexPath.item]
    }
}

extension HomeViewController {
    
    @objc private func leftItemClick() {
        
    }
    
    @objc private func rightItemClick() {
        
    }
}
