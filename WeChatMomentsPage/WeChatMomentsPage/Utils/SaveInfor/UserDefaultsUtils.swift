//
//  UserDefaultsUtils.swift
//  WeChatMomentsPage
//
//  Created by BeiBeiLewis ZHU on 2020/12/22.
//  Copyright © 2020 BeiBeiLewis ZHU. All rights reserved.
//

import UIKit

struct UserDefaultsKey {
    static let TweetsForm = "TweetsFormModels"
}

struct UserDefaultsUtils {

    func saveModel(_ tweetsForms: [TweetsForm]) {
        let userDefault = UserDefaults.standard
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(tweetsForms){
            userDefault.set(encoded, forKey: UserDefaultsKey.TweetsForm)
            userDefault.synchronize()
        }
    }
    
    func obtainModels(_ page: Int) -> [TweetsForm]? {
        if let objects = UserDefaults.standard.value(forKey: UserDefaultsKey.TweetsForm) as? Data {
            let decoder = JSONDecoder()
            if let objects = try? decoder.decode(Array.self, from: objects) as [TweetsForm] {
                let displayCount: Int = page * 5
                if displayCount > objects.count {
                    return objects
                } else {
                    return Array(objects[0..<displayCount])
                }
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
}
