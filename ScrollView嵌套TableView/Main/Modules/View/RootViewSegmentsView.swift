//
//  RootViewSegmentsView.swift
//  ScrollView嵌套TableView
//
//  Created by Joe on 2020/7/24.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit

class RootViewSegmentsView: RootViewSegmentsBaseView {
    
    override var isScrollEnabled: Bool? {
        didSet {
            segmentsLeftTableView.isScrollEnabled = isScrollEnabled
            segmentsRightTableView.isScrollEnabled = isScrollEnabled
        }
    }
    
    override var contentOffset: CGPoint? {
        didSet {
            segmentsLeftTableView.contentOffset = contentOffset
            segmentsRightTableView.contentOffset = contentOffset
        }
    }
    
    //视图
    
    //Base视图
    private lazy var contentView: CustomScrollView = {
        let c = CustomScrollView()
        c.contentSize = CGSize(width: kScreenW*2, height: 0)
        c.isPagingEnabled = true
        return c
    }()
    
    ///Left tableView
    private lazy var segmentsLeftTableView: RootViewSegmentsTableView = {
        let s = RootViewSegmentsTableView()
        return s
    }()

    ///Right tableView
    private lazy var segmentsRightTableView: RootViewSegmentsTableView = {
        let s = RootViewSegmentsTableView()
        return s
    }()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH-47))
        setUI()
        setDefaultParams()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        addSubview(contentView)
        contentView.addSubview(segmentsLeftTableView)
        contentView.addSubview(segmentsRightTableView)
        
        contentView.snp.updateConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        segmentsLeftTableView.snp.updateConstraints { (make) in
            make.left.equalToSuperview()
            make.size.equalTo(CGSize(width: kScreenW, height: bounds.size.height))
            make.centerY.equalToSuperview()
        }
        
        segmentsRightTableView.snp.updateConstraints { (make) in
            make.left.equalTo(segmentsLeftTableView.snp.right)
            make.size.centerY.equalTo(segmentsLeftTableView)
        }
        
    }
    
    private func setDefaultParams() {
        isScrollEnabled = false
    }
    
}

class RootViewSegmentsBaseView: UIView {
    
    var isScrollEnabled: Bool?
    var contentOffset: CGPoint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
