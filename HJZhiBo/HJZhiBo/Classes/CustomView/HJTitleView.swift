//
//  HJTitleView.swift
//  HJZhiBo
//
//  Created by lulu on 2018/8/15.
//  Copyright © 2018年 Jermy. All rights reserved.
//

import UIKit


protocol HJTitleViewDelegate : class {
    func titleViewDidScrolled(index : Int)
}

// MARK: HJTitleViewStyle

class HJTitleViewStyle {
    var isScrollEnable: Bool = false
    var titleColor: UIColor = .orange
    var titleViewBGColor: UIColor = .clear
    var titleFontSize: CGFloat = 15
    var titleSelecteColor: UIColor = .red
    var titleMargin: CGFloat = 30
}

// MARK: HJTitleView

class HJTitleView: UIView {

    private var titles: [String] = [String]()
    private var style: HJTitleViewStyle = HJTitleViewStyle()
    private var currentLabel : UILabel? = nil
    weak var delegate : HJTitleViewDelegate?
    
    //存放所有标题label的数组
    private var titleLabels: [UILabel] = {
        let labels: [UILabel] = [UILabel]()
        return labels
    }()
    
    //标题view的scrollview
    lazy private var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: self.bounds)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        return scrollView
    }()
    
    //构造函数
    init(frame: CGRect, titles: [String], style: HJTitleViewStyle) {
        super.init(frame: frame)
        self.titles = titles
        self.style = style
        self.backgroundColor = style.titleViewBGColor
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func titleViewScrollToIndex(index : Int) {
        
        if index == currentLabel?.tag {
            return
        }
        
        let label = titleLabels[index]
        
        label.textColor = style.titleSelecteColor
        
        currentLabel?.textColor = style.titleColor
        currentLabel = label
        
        var offsetX = label.center.x - bounds.width * 0.5
        if offsetX < 0 {
            offsetX = 0
        }
        
        let maxOffset = scrollView.contentSize.width - bounds.width
        if offsetX > maxOffset {
            offsetX = maxOffset
        }
        
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}

extension HJTitleView {
    private func setupUI() {
        
        //添加scrollView
        setupScrollView()
        
        //添加标题label
        setupTitleLabels()
        
        //设置label的frame
        setTitleLabelFrame()
    }
    
    private func setupScrollView() {
        addSubview(scrollView)
    }
    
    private func setupTitleLabels() {
    
        for i in 0..<titles.count {
            
            let label = UILabel()
            label.text = titles[i]
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: style.titleFontSize)
            label.textColor = style.titleColor
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(titleViewTapEvent(tapGesture:)))
            label.addGestureRecognizer(tapGes)
            scrollView.addSubview(label)
            label.tag = i
            
            if i == 0 {
                label.textColor = style.titleSelecteColor
                currentLabel = label
            }
 
            titleLabels.append(label)
        }
    }
    
    private func setTitleLabelFrame() {
        
        var titleW: CGFloat = frame.size.width / CGFloat(titles.count)
        let titleH: CGFloat = frame.height
        var titleX: CGFloat = 0
        let titleY: CGFloat = 0
    
        for label in titleLabels {
            let index = label.tag
            
            if style.isScrollEnable {
                let title = titles[index]
                
                titleW = (title as NSString).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: 0), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: style.titleFontSize)], context: nil).width
                
                if index == 0 {
                    titleX = style.titleMargin * 0.5
                }else {
                    let preLabel = titleLabels[index - 1]
                    titleX = preLabel.frame.maxX + style.titleMargin
                }
            }else {
                titleX = CGFloat(index) * titleW
            }
            
            label.frame = CGRect(x: titleX, y: titleY, width: titleW, height: titleH)
        }
        
        if style.isScrollEnable {
            scrollView.contentSize = CGSize(width: (titleLabels.last?.frame.maxX)! + style.titleMargin * 0.5, height: 0)
        }
    }
}

//MARK: 标题label点击事件
extension HJTitleView {
    @objc func titleViewTapEvent(tapGesture : UITapGestureRecognizer) {
        let label : UILabel = tapGesture.view as! UILabel
        label.textColor = style.titleSelecteColor
        
        currentLabel?.textColor = style.titleColor
        currentLabel = label
        
        var offsetX = label.center.x - bounds.width * 0.5
        if offsetX < 0 {
            offsetX = 0
        }
        
        let maxOffset = scrollView.contentSize.width - bounds.width
        if offsetX > maxOffset {
            offsetX = maxOffset
        }
        
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
        
        delegate?.titleViewDidScrolled(index: (label.tag))
    }
}
