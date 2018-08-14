//
//  RootViewController.swift
//  HJZhiBo
//
//  Created by Jermy on 2018/8/14.
//  Copyright © 2018年 Jermy. All rights reserved.
//

import UIKit

class RootViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewController(viewController: HJNavigationController(rootViewController: HomeViewController()), title: "首页", image: "live")
        setupViewController(viewController: RankViewController(), title: "排行", image: "ranking")
        setupViewController(viewController: DiscoverViewController(), title: "发现", image: "found")
        setupViewController(viewController: ProfileViewController(), title: "我的", image: "mine")
    }
    
    func setupViewController (viewController: UIViewController ,title : String, image : String) {
        
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = UIImage(named: "\(image)-n")
        viewController.tabBarItem.selectedImage = UIImage(named: "\(image)-p")
        
        let attrNormal = [NSAttributedStringKey.foregroundColor : UIColor.gray]
        let attrSelected = [NSAttributedStringKey.foregroundColor : UIColor.orange]
        viewController.tabBarItem.setTitleTextAttributes(attrNormal, for: UIControlState.normal)
        viewController.tabBarItem.setTitleTextAttributes(attrSelected, for: UIControlState.selected)
        self.addChildViewController(viewController)
    }
}
