//
//  BJmainViewController.swift
//  BJLookupData
//
//  Created by binj on 16/6/17.
//  Copyright © 2016年 binj. All rights reserved.
//

import UIKit

// 定义一个闭包函数
typealias changeTitleBlock = (title: String, newColor: UIColor) -> Void
/// **声明函数闭包*
var changeTitle = changeTitleBlock?()

class BJmainViewController: UIViewController {
    
    var collectionView: UICollectionView?
    var collectionViewCell: BJCollectionViewCell?
    var collectionViewLayout: BJCollectionViewLayout?
    var selectCell = BJCollectionViewCell()
    struct itemIdent{
        
        static let mainCollectionCell = "mainCollectionCell"
    }
    
    //懒加载
    lazy var imageArrary:[String] = {
        
        var array:[String] = []
        
        for i in 0...3 {
            array.append("colletctionImage_\(i)")
        }
        return array
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "公交车"
        view.backgroundColor = UIColor.lightGrayColor()
        buildCollectionView()
    
        // 设置导航条按钮颜色
        changeNavigationInfo()
        // 初始化block
        changeTitle = {
            tempTitle,newColor in
            self.title = tempTitle
            // 设置导航条背景色
            self.navigationController?.navigationBar.barTintColor = newColor
            
            self.view.backgroundColor = newColor
            self.collectionView?.backgroundColor = newColor
            self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        }
    }
    
    private func changeNavigationInfo(){
        // 设置导航条字体颜色
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        // 自定义导航条按钮
        let leftBar = UIButton(type: UIButtonType.Custom)
        leftBar.frame = CGRect(x: 0, y: 0, width: 30.0, height: 30.0)
        leftBar.setImage(UIImage.init(named: "nav_more.png"), forState: UIControlState.Normal);
        leftBar.setImage(UIImage.init(named: "nav_more.png"), forState: UIControlState.Highlighted)
        leftBar.backgroundColor = UIColor.clearColor()
        let leftItme = UIBarButtonItem(customView: leftBar)
        navigationItem.setLeftBarButtonItem(leftItme, animated: true)
        leftBar.addTarget(self, action: #selector(BJmainViewController.clickMoreBtn(_:)), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func clickMoreBtn(btn:UIButton){
        
    }
    
    
    private func buildCollectionView() {
        collectionViewLayout = BJCollectionViewLayout.init()
        
        collectionView = UICollectionView(frame:  CGRectMake(0, CGRectGetHeight(self.view.bounds)/2-(300/2), self.view.bounds.width, 300),
                                          collectionViewLayout: collectionViewLayout!)
        collectionView?.backgroundColor = UIColor.lightGrayColor()
        collectionView?.showsHorizontalScrollIndicator = false
        guard collectionView != nil else{
            return
        }
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        // 注意一个类的表示
        collectionView?.registerClass(BJCollectionViewCell.self, forCellWithReuseIdentifier: itemIdent.mainCollectionCell)
        
        view.addSubview(collectionView!)
        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if self.collectionView!.collectionViewLayout.isKindOfClass(BJCollectionViewLayout) {
            
            self.collectionView?.setCollectionViewLayout(UICollectionViewFlowLayout(), animated: true)
        }else{
        
            self.collectionView?.setCollectionViewLayout(BJCollectionViewLayout(), animated: true)
        }
    }
    
    
    func changeTitleForItme(tempTitle: String){
        
        self.title = tempTitle
        
    }
}


extension BJmainViewController: UICollectionViewDelegate{
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        selectCell = collectionView.cellForItemAtIndexPath(indexPath) as! BJCollectionViewCell

        
        // 这个根据自定的业务来规定点击item时的动作
        /**
        switch self.title! {
        case "公交车":
            let toVC = BJPublicBusViewController()
            transtionFromVcContext = NSStringFromClass(BJPublicBusViewController)
            toVC.title = self.title
            toVC.view.backgroundColor = self.view.backgroundColor
            toVC.headerImageView?.image = selectCell.imageView?.image
            navigationController?.pushViewController(toVC, animated: true)
            break
        case "微信精选":
            let toVC = BJWXArticleViewController()
            toVC.title = self.title
            transtionFromVcContext = NSStringFromClass(BJWXArticleViewController)
            toVC.view.backgroundColor = self.view.backgroundColor
            toVC.headerImageView?.image = selectCell.imageView?.image
            navigationController?.pushViewController(toVC, animated: true)
            break
        case "长途汽车":
            let toVC = BJBusViewController()
            toVC.title = self.title
            transtionFromVcContext = NSStringFromClass(BJBusViewController)
            toVC.view.backgroundColor = self.view.backgroundColor
            toVC.headerImageView?.image = selectCell.imageView?.image
            navigationController?.pushViewController(toVC, animated: true)
            break
        case "IP地址":
            let toVC = BJIPAddressViewController()
            toVC.title = self.title
            transtionFromVcContext = NSStringFromClass(BJIPAddressViewController)
            toVC.view.backgroundColor = self.view.backgroundColor
            toVC.headerImageView?.image = selectCell.imageView?.image
            navigationController?.pushViewController(toVC, animated: true)
            break
        default:
            BJLog("没有匹配到可跳转的控制器")
            return
        }
         */
    }
}



extension BJmainViewController:UICollectionViewDataSource{
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(itemIdent.mainCollectionCell, forIndexPath: indexPath) as? BJCollectionViewCell
        cell?.layer.cornerRadius = 10
        cell?.imageStr = imageArrary[indexPath.row]
        return cell!
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return imageArrary.count
    }
}





