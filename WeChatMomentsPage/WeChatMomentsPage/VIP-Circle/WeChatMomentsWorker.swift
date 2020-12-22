//
//  WeChatMomentsWorker.swift
//  WeChatMomentsPage
//
//  Created by BeiBeiLewis ZHU on 2020/12/21.
//  Copyright © 2020 BeiBeiLewis ZHU. All rights reserved.
//

import UIKit

class WeChatMomentsWorker: NSObject {

    private struct RequestUrl {
        static let UserInfor = "https://thoughtworks-mobile-2018.herokuapp.com/user/jsmith"
        static let Tweets = "https://thoughtworks-mobile-2018.herokuapp.com/user/jsmith/tweets"
    }
    
    func request(userInforCompletion: @escaping (_ results: UserInfo?) -> (),
                 tweetsFormCompletion: @escaping (_ results: [TweetsForm]?) -> ()) {
        
        let group = DispatchGroup()

        let userInfoQueue = DispatchQueue(label: "com.user")
        let tweetsQueue = DispatchQueue(label: "com.tweets")
        
        group.enter()
        userInfoQueue.async {
            NetworkTools.shareInstance.request(methodType: .GET, urlString: RequestUrl.UserInfor, parameters: nil) { (result, _, error) in
                if (error != nil) {
                    userInforCompletion(nil)
                    return
                }
                if let response = result as? [String: Any]{
                    let model = DictionaryDecoder.decode(UserInfo.self, param: response)
                    userInforCompletion(model)
                }
                group.leave()
            }
        }
        
        group.enter()
        tweetsQueue.async {
            NetworkTools.shareInstance.request(methodType: .GET, urlString: RequestUrl.Tweets, parameters: nil) { (result, _, error) in
                if (error != nil) {
                    tweetsFormCompletion(nil)
                    return
                }
                if let response = result as? [[String: Any]]{
                    let model = DictionaryDecoder.decode(TweetsForm.self, array: response)
                    tweetsFormCompletion(model)
                }
                group.leave()
            }
        }
        
        
        
        group.notify(queue: .main) {
        }
    }
    
    
}
