//
//  ActivityView.swift
//  WeChatMomentsPage
//
//  Created by BeiBeiLewis ZHU on 2020/12/23.
//  Copyright © 2020 BeiBeiLewis ZHU. All rights reserved.
//

import UIKit

class ActivityView: UIView {

    
    static let shared = ActivityView()
    
    lazy var baseView = UIView()
    lazy var activityIndicatorView = UIActivityIndicatorView()
    

    private init() {
        super.init(frame:CGRect.zero)
        self.frame = CGRect(x: 0, y: 0, width: Constant.ScreenWidth, height: Constant.ScreenHeight)
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func setupUI() {
        baseView.frame = frame
        self.backgroundColor = .clear
        self.addSubview(baseView)
        self.activityIndicatorView.center = self.center
        self.activityIndicatorView.color = .black
        baseView.addSubview(activityIndicatorView)
    }
    
    func start() {
        let window = FundamentalUtils.shard.obtainKeyWindow()
        window?.addSubview(self)
        self.activityIndicatorView.startAnimating()
    }
    
    func stop() {
        self.removeFromSuperview()
        self.activityIndicatorView.stopAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
