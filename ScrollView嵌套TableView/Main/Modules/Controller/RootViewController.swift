//
//  RootViewController.swift
//  ScrollView嵌套TableView
//
//  Created by Joe on 2020/7/24.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit

class RootViewController: BaseViewController {
    
    private var contentViewCanMove = false
    private var segmentsViewCanMove = false
    
    //视图
    
    ///Base视图
    private lazy var contentView: CustomScrollView = {
        let c = CustomScrollView()
        c.delegate = self
        c.contentInsetAdjustmentBehavior = .never
        c.contentSize = CGSize(width: kScreenW, height: kScreenH*1.5)
        return c
    }()
    
    ///segment
    private lazy var segment: RootViewSegment = {
        let s = RootViewSegment()
        return s
    }()
    
    ///segmentsView
    private lazy var segmentsView: RootViewSegmentsView = {
        let s = RootViewSegmentsView()
        return s
    }()
    
    ///header
    private lazy var header: RootViewHeader = {
        let h = RootViewHeader()
        return h
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        addNotifications()
        addPanGesture()
    }
    
    //MARK: - UI
    
    private func setUI() {
        view.addSubview(contentView)
        contentView.addSubview(header)
        contentView.addSubview(segment)
        contentView.addSubview(segmentsView)
        
        segment.frame.origin.y = header.frame.maxY
        segmentsView.frame.origin.y = segment.frame.maxY
        
        contentView.snp.updateConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }

    private func addNotifications() {
        NotificationCenter.default.addObserver(forName: RootViewNotifications.contentViewCanMove, object: nil, queue: OperationQueue.main) { [weak self] (notification) in
            guard let `self` = self else {return}
            self.segmentsView.contentOffset = .zero
            self.segmentsView.isScrollEnabled = false
            self.segmentsViewCanMove = false
            self.contentView.isScrollEnabled = true
            self.contentViewCanMove = true
        }
    }
    
    private func addPanGesture() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panAction(_:)))
        pan.delegate = self
        contentView.addGestureRecognizer(pan)
    }
    
    private var currentPanY: CGFloat = 0
    @objc private func panAction(_ panGesture: UIPanGestureRecognizer) {
        
        if panGesture.state != .changed {
            //清空状态
            currentPanY = 0
            contentViewCanMove = false
            segmentsViewCanMove = false
        } else {
            let currentY = panGesture.translation(in: contentView).y
            //滑动中经过了临界点
            if contentViewCanMove || segmentsViewCanMove {
                if currentPanY == 0 {
                    //记录经过临界点时的y
                    currentPanY = currentY
                }
                //计算临界点后的y
                let offSetY = currentPanY - currentY
                
                if contentViewCanMove {
                    let supposeY = maxOffSetY() + offSetY
                    if supposeY >= 0 {
                        contentView.contentOffset = CGPoint(x: 0, y: supposeY)
                    } else {
                        contentView.contentOffset = .zero
                    }
                } else {
                    segmentsView.contentOffset = CGPoint(x: 0, y: offSetY)
                }
            }
        }
    }
    
}

extension RootViewController: UIScrollViewDelegate, UIGestureRecognizerDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //悬停效果
        if scrollView.contentOffset.y >= maxOffSetY() {
            scrollView.contentOffset = CGPoint(x: 0, y: maxOffSetY())
            contentView.isScrollEnabled = false
            contentViewCanMove = false
            segmentsView.isScrollEnabled = true
            segmentsViewCanMove = true
        }
        
    }
    
    private func maxOffSetY() -> CGFloat {
        return header.frame.size.height
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}
