//
//  Constant.swift
//  ScrollView嵌套TableView
//
//  Created by Joe on 2020/7/24.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit
import SnapKit

///屏幕Size
public let kScreenSize = UIScreen.main.bounds.size

///屏幕高
public let kScreenW = kScreenSize.width

///屏幕宽
public let kScreenH = kScreenSize.height

///导航栏高
public let kNavigationBarH: CGFloat = 44

///导航栏+状态栏高
public let kStatusBarNavigationBarH = UIApplication.shared.statusBarFrame.size.height + kNavigationBarH

extension UIColor {
    
    ///随机色
    open class var randomColor: UIColor {
        get {
            return UIColor(red: CGFloat(arc4random()%256)/255.0, green: CGFloat(arc4random()%256)/255.0, blue: CGFloat(arc4random()%256)/255.0, alpha: 1)
        }
    }
    
}
