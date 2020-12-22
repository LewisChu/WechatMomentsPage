//
//  WeChatMomentsViewController.swift
//  WeChatMomentsPage
//
//  Created by BeiBeiLewis ZHU on 2020/12/17.
//  Copyright © 2020 BeiBeiLewis ZHU. All rights reserved.
//

import UIKit

// Presenter output
protocol WeChatMomentsDisplayLogic: class {
    func getUserInfoSuccess(_ userInfo: UserInfo)
    func getUserInfoFailure()
    
    func getTweetsFromSuccess(_ tweetsForms: [TweetsForm])
    func getTweetsFromFailure()
}

class WeChatMomentsViewController: UIViewController {
    
    // MARK: VIP Circle Parameter
    var interactor: WeChatMomentsBusinessLogic?
    var router: WeChatMomentsRoutingLogic?
    // MARK: VIP Circle Parameter end
    
    private func setup() {
        let viewController = self
        let presenter = WeChatMomentsPresenter()
        let interactor = WeChatMomentsInteractor()
        let router = WeChatMomentsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactor?.obtainInforBusiness()
        
        
        
        
    }
}

extension WeChatMomentsViewController: WeChatMomentsDisplayLogic {
    func getUserInfoSuccess(_ userInfo: UserInfo) {
        print(userInfo)
    }
    
    func getUserInfoFailure() {
        
    }
    
    func getTweetsFromSuccess(_ tweetsForms: [TweetsForm]) {
        print(tweetsForms.count)
    }
    
    func getTweetsFromFailure() {
        
    }
}


