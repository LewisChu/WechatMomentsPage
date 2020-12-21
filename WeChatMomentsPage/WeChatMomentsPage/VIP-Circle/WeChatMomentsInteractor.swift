//
//  WeChatMomentsInteractor.swift
//  WeChatMomentsPage
//
//  Created by BeiBeiLewis ZHU on 2020/12/21.
//  Copyright © 2020 BeiBeiLewis ZHU. All rights reserved.
//


// ViewContoller output
protocol WeChatMomentsBusinessLogic {
}

class WeChatMomentsInteractor {
    var presenter: WeChatMomentsPresentationLogic?
    var worker: WeChatMomentsWorker?
}

extension WeChatMomentsInteractor: WeChatMomentsBusinessLogic {
    
}
