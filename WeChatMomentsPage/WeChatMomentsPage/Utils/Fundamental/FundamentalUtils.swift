//
//  FundamentalUtils.swift
//  WeChatMomentsPage
//
//  Created by BeiBeiLewis ZHU on 2020/12/23.
//  Copyright © 2020 BeiBeiLewis ZHU. All rights reserved.
//

import UIKit

class FundamentalUtils: UIView {
    
    static let shard = FundamentalUtils()
    
    func obtainKeyWindow() -> UIWindow? {
        var window: UIWindow? = nil
        if #available(iOS 13.0, *) {
            for windowScene: UIWindowScene in (UIApplication.shared.connectedScenes as? Set<UIWindowScene>)! {
                if windowScene.activationState == .foregroundActive {
                    window = windowScene.windows.last
                }
                break
            }
        } else {
            window = UIApplication.shared.keyWindow
        }

        return window
    }

}
