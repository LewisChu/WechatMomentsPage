//
//  WeChatMomentsPresenter.swift
//  WeChatMomentsPage
//
//  Created by BeiBeiLewis ZHU on 2020/12/21.
//  Copyright © 2020 BeiBeiLewis ZHU. All rights reserved.
//  


// Interactor output
protocol WeChatMomentsPresentationLogic {
//  func presentLoginResult(_ response: LoginResponsData?)
//  func presentErrorLoginResult(_ response: BaseResponse?)
}

class WeChatMomentsPresenter {
    weak var viewController: WeChatMomentsViewController?
}

extension WeChatMomentsPresenter: WeChatMomentsPresentationLogic {
    
}
