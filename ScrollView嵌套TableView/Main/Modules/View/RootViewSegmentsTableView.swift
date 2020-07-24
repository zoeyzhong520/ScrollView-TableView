//
//  RootViewSegmentsTableView.swift
//  ScrollView嵌套TableView
//
//  Created by Joe on 2020/7/24.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit

class RootViewSegmentsTableView: RootViewSegmentsBaseView {
    
    override var isScrollEnabled: Bool? {
        didSet {
            tableView.isScrollEnabled = isScrollEnabled == true
        }
    }
    
    override var contentOffset: CGPoint? {
        didSet {
            guard let `contentOffset` = contentOffset else { return }
            tableView.contentOffset = contentOffset
        }
    }

    ///tableView
    private lazy var tableView: CustomTableView = {
        let t = CustomTableView()
        t.delegate = self
        t.dataSource = self
        t.separatorStyle = .none
        t.register(UITableViewCell.self, forCellReuseIdentifier: self.cellIdentifier)
        return t
    }()
    
    ///Cell identifier
    private let cellIdentifier = "cellIdentifier"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        addSubview(tableView)
        
        tableView.snp.updateConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
}

extension RootViewSegmentsTableView: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) else { return UITableViewCell(style: .default, reuseIdentifier: cellIdentifier) }
        cell.textLabel?.text = cellIdentifier
        cell.textLabel?.textColor = .black
        cell.selectionStyle = .none
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= 0 {
            NotificationCenter.default.post(name: RootViewNotifications.contentViewCanMove, object: nil)
        }
    }
}
