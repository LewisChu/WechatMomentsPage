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
//    func loginSuccessfulDisplay(_ response: LoginResponsData?)
//    func loginErrorDisplay(_ response: BaseResponse?)
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
        
    }
}

extension WeChatMomentsViewController: WeChatMomentsDisplayLogic {
    
}
