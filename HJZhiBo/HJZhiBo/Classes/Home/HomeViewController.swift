//
//  HomeViewController.swift
//  HJZhiBo
//
//  Created by Jermy on 2018/8/14.
//  Copyright © 2018年 Jermy. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

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
        
    }
}

extension HomeViewController {
    
    @objc private func leftItemClick() {
        
    }
    
    @objc private func rightItemClick() {
        
    }
}
