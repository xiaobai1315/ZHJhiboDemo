//
//  HJWaterFallLayout.swift
//  HJZhiBo
//
//  Created by lulu on 2018/8/17.
//  Copyright © 2018年 Jermy. All rights reserved.
//

import UIKit

protocol HJWaterFallLayoutDelegate : class {
    func HJWaterFallLayoutHeightForItemAtIndexPath(indexPath : IndexPath) -> CGFloat
}

class HJWaterFallLayout: UICollectionViewLayout {

    //外边传进来的总列数，默认是2
    var numberOfCol : Int = 2
    //外边传进来的行之间的间距，默认是10
    var margin : CGFloat = 10
    
    var delegate : HJWaterFallLayoutDelegate?
    
    private var _attributesArray : [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    //保存每列的总高度
    private var _colHeightDic : [Int : CGFloat] = [Int : CGFloat]()
    
    //列宽，根据列数和间距计算
    private lazy var _cellWidth : CGFloat = {
        return (UIScreen.main.bounds.width - margin * CGFloat(numberOfCol + 1)) / CGFloat(numberOfCol)
    }()
    override func prepare() {
        super.prepare()
        
        //初始化列高
        for i in 0 ..< numberOfCol {
            _colHeightDic[i] = margin
        }
        
        //布局item
        for i in 0 ..< collectionView!.numberOfItems(inSection: 0) {
            let att = layoutAttributesForItem(at: IndexPath(item: i, section: 0))
            _attributesArray.append(att!)
        }
    }
    
    override var collectionViewContentSize: CGSize {
        var height : CGFloat = 0
        
        for i in 0 ..< numberOfCol {
            let temp = _colHeightDic[i]
            if height < temp! {
                height = temp!
            }
        }
        
        return CGSize(width: 0, height: height)
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let att = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        
        //查找最短的列
        var col : Int = 0
        var height : CGFloat = _colHeightDic[0]!
        
        for i in 0 ..< numberOfCol {
            let tempHeight = _colHeightDic[i]
            if (tempHeight! < height) {
                height = tempHeight!
                col = i
            }
        }
        
        //取出外边传进来的cell高度
        let itemHeight = delegate?.HJWaterFallLayoutHeightForItemAtIndexPath(indexPath: indexPath)
        
        let itemX = CGFloat(col) * (_cellWidth + margin)
        let itemY = height
        
        att.frame = CGRect(x: itemX, y: itemY, width: _cellWidth, height: itemHeight!)
        
        //更新列高
        let newHeight = height + itemHeight! + margin
        _colHeightDic[col] = newHeight
        
        return att
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return _attributesArray
    }
}
