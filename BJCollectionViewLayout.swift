//
//  BJCollectionViewLayout.swift
//  BJLookupData
//
//  Created by binj on 16/6/17.
//  Copyright © 2016年 binj. All rights reserved.
//

import UIKit


class BJCollectionViewLayout: UICollectionViewFlowLayout {
    
    /// BJActiveDistance 规定距离，来判断是否该放大现实itme
    let BJActiveDistance: CGFloat = 60.0
    /// Scale 缩放比例（原理，离屏幕中心点越近，itme应该放大）
    let Scale: CGFloat  = 0.2
    var itemW: CGFloat = 300
    var itemH: CGFloat = 300
    lazy var insert: CGFloat = {
        return  (self.collectionView?.bounds.width ?? 0)  * 0.5 - self.itemSize.width * 0.5
    }()
    
    
    
    override init() {
        super.init()
        
        self.itemSize = CGSize(width: 150, height: 150)
        // 设置为水平显示
        scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        // 每个item之间的间隙
        minimumLineSpacing = 100.0
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /**
     实现这个方法的目的是：当停止滑动，时刻有一张图片是位于屏幕最中央的。
     
     - parameter proposedContentOffset: 原来collectionView停止滚动那一刻itme的位置
     - parameter velocity:              速度
     
     - returns: 返回最终collectionView停止的位置
     */
    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint,
                                                              withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        // 需要偏移的距离
        var offsetAdjustment = CGFloat(MAXFLOAT)
        // 计算itme滚动到屏幕中央的x位置
        let horizontalCenterX = proposedContentOffset.x + (CGRectGetWidth((self.collectionView?.bounds) ?? CGRectZero))/2.0
        
        // 计算collectionView落在屏幕上的大小
        let targetRect = CGRect(x: proposedContentOffset.x,
                                y: proposedContentOffset.y,
                                width: CGRectGetWidth((self.collectionView?.bounds)!),
                                height: CGRectGetHeight((self.collectionView?.bounds)!))
        
        // 获取落在屏幕中的所有itme
        var itmes = super.layoutAttributesForElementsInRect(targetRect)
        
        // 遍历所有屏幕中的itme，找到最接近中心的一个itme
        if itmes?.count > 0 {
            for i in 0...itmes!.count - 1 {
                
                let LayoutAttributes = itmes![i]
                let LayoutAttributesCenterX = LayoutAttributes.center.x
                
                BJLog("LayoutAttributesCenterX.hashValue = \(LayoutAttributesCenterX)")
                if abs(LayoutAttributesCenterX - horizontalCenterX) < abs(offsetAdjustment) {
                    offsetAdjustment = (LayoutAttributesCenterX) - (horizontalCenterX)
                }
            }
        }
        
        let point = CGPoint(x:proposedContentOffset.x + CGFloat(offsetAdjustment), y: proposedContentOffset.y)
        
        return point
    }
    
    
    
    

    /** 
         取出rect范围内的所有itme
         有效距离:当item的中间x距离屏幕的中间x在BJActiveDistance以内,才会开始放大, 其它情况都是缩小
     
         取出rect范围内所有的UICollectionViewLayoutAttributes，然而
         我们并不关心这个范围内所有的cell的布局，我们做动画是做给人看的，
         所以我们只需要取出屏幕上可见的那些cell的rect即可
     */
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]?{
        // 调用父类来获取所有itme
        let itmeArray = super.layoutAttributesForElementsInRect(rect)

        //接下来的计算是为了动画效果
        let maxCenterMargin = self.collectionView!.bounds.width * 0.5 + itemW * 0.5;
        let centerX = self.collectionView!.contentOffset.x + self.collectionView!.frame.size.width * 0.5;
        
        if abs(centerX) < 300{
            changeTitle!(title: "公交车",newColor: UIColor(colorLiteralRed: 184.0/255.0, green: 183.0/255.0, blue: 156.0/255.0, alpha: 1.0))
        }else if 300 < abs(centerX) && abs(centerX) < 600{
            changeTitle!(title: "微信精选",newColor: UIColor(colorLiteralRed: 31.0/255.0, green: 196.0/255.0, blue: 91.0/255.0, alpha: 1.0))
        }else if 600 < abs(centerX) && abs(centerX) < 900{
            changeTitle!(title: "长途汽车",newColor: UIColor(colorLiteralRed: 16.0/255.0, green: 131.0/255.0, blue: 255.0/255.0, alpha: 1.0))
        }else if 900 < abs(centerX) && abs(centerX) < 1200{
            changeTitle!(title: "IP地址",newColor: UIColor(colorLiteralRed: 33.0/255.0, green: 28.0/255.0, blue: 33.0/255.0, alpha: 1.0))
        }
        
        
        
        // 遍历所有屏幕类的itme
        if itmeArray?.count > 0 {
            for i in 0...itmeArray!.count - 1 {
                let LayoutAttribute = itmeArray![i]
                
                // 判断LayoutAttribute.frame是否在rect范围内
                if CGRectIntersectsRect(LayoutAttribute.frame, rect) {
                    
                    let scale = 1 + (1 - abs(centerX - LayoutAttribute.center.x) / maxCenterMargin)
                    
                    BJLog("centerX\(centerX)")
                    BJLog("LayoutAttribute.center.x\(LayoutAttribute.center.x)")
                    BJLog("scale\(scale)")
                    BJLog("\(centerX),\(self.collectionView!.contentOffset.x),\(self.collectionView!.frame.size.width)")
                    
                    LayoutAttribute.transform3D = CATransform3DMakeScale(scale, scale, 1.0)
                }
            }
        }
        return itmeArray
    }
    
    
    
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
    
    override func prepareLayout() {
        
        //设置边距(让第一张图片与最后一张图片出现在最中央)
        self.sectionInset = UIEdgeInsets(top: 0, left: insert, bottom: 0, right: insert)
    }
    
    
}
