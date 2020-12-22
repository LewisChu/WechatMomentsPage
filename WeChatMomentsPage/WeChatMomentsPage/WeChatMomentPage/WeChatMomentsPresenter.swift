//
//  WeChatMomentsPresenter.swift
//  WeChatMomentsPage
//
//  Created by BeiBeiLewis ZHU on 2020/12/21.
//  Copyright © 2020 BeiBeiLewis ZHU. All rights reserved.
//  

import UIKit

// Interactor output
protocol WeChatMomentsPresentationLogic {
    func userInfoSuccessfulPresentation(_ userInfo: UserInfo)
    func userInfoFailedPresentation()

    func tweetsFormSuccessfulPresentation(_ tweetsForms: [TweetsForm])
    func tweetsFormFailedPresentation()
}

class WeChatMomentsPresenter {
    weak var viewController: WeChatMomentsViewController?
}

extension WeChatMomentsPresenter: WeChatMomentsPresentationLogic {
    
    func userInfoSuccessfulPresentation(_ userInfo: UserInfo) {
        self.viewController?.getUserInfoSuccess(userInfo)
    }
    func userInfoFailedPresentation() {
        self.viewController?.getUserInfoFailure()
    }

    func tweetsFormSuccessfulPresentation(_ tweetsForms: [TweetsForm]) {
        // filter the tweet which does not contain a content and images
        let tweets = tweetsForms.filter {
            if let _ = $0.content {
                return true
            } else if let _ = $0.images {
                return true
            } else {
                return false
            }
        }
        // save tweet to userdefaults
        UserDefaultsUtils().saveModel(tweets)
        self.viewController?.getTweetsFromSuccess((tweets.count > 4) ? Array(tweets[0..<5]) : tweets)
    }
    func tweetsFormFailedPresentation() {
        self.viewController?.getTweetsFromFailure()
    }
}
