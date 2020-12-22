//
//  WeChatMomentsInteractor.swift
//  WeChatMomentsPage
//
//  Created by BeiBeiLewis ZHU on 2020/12/21.
//  Copyright © 2020 BeiBeiLewis ZHU. All rights reserved.
//


// ViewContoller output
protocol WeChatMomentsBusinessLogic {
    func obtainInforBusiness()
}

class WeChatMomentsInteractor {
    var presenter: WeChatMomentsPresentationLogic?
    var worker: WeChatMomentsWorker?
}

extension WeChatMomentsInteractor: WeChatMomentsBusinessLogic {
    
    func obtainInforBusiness() {
        self.worker = WeChatMomentsWorker()
        self.worker?.request(userInforCompletion: { (userInfor) in
            if let userInfoModel = userInfor {
                self.presenter?.userInfoSuccessfulPresentation(userInfoModel)
            } else {
                self.presenter?.userInfoFailedPresentation()
            }
        }, tweetsFormCompletion: { (tweetsForm) in
            if let tweetsFormModel = tweetsForm {
                self.presenter?.tweetsFormSuccessfulPresentation(tweetsFormModel)
            } else {
                self.presenter?.tweetsFormFailedPresentation()
            }
        })
    }
}
