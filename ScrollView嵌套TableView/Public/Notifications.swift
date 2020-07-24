//
//  Notifications.swift
//  ScrollView嵌套TableView
//
//  Created by Joe on 2020/7/24.
//  Copyright © 2020 Joe. All rights reserved.
//

import Foundation

struct RootViewNotifications {
    static let contentViewCanMove = Notification.Name("com.mbp.RootViewNotifications.contentViewCanMove")
    static let contentViewCanNotMove = Notification.Name("com.mbp.RootViewNotifications.contentViewCanNotMove")
}
