//
//  RootViewHeader.swift
//  ScrollView嵌套TableView
//
//  Created by Joe on 2020/7/24.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit

class RootViewHeader: UIView {

    private lazy var titleLb: UILabel = {
        let t = UILabel()
        t.text = "我是Header"
        t.textColor = UIColor.randomColor
        t.font = UIFont.boldSystemFont(ofSize: 18)
        t.textAlignment = .center
        return t
    }()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kScreenW/(375/210)))
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        backgroundColor = UIColor.randomColor
        
        addSubview(titleLb)
        
        titleLb.snp.updateConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }

}
