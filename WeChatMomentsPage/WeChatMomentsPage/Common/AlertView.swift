//
//  AlertView.swift
//  WeChatMomentsPage
//
//  Created by BeiBeiLewis ZHU on 2020/12/23.
//  Copyright © 2020 BeiBeiLewis ZHU. All rights reserved.
//

import UIKit

class AlertView: UIView {
    
    private struct AlertViewConstraint {
        static let TextLabelMargin = CGFloat(50)
    }
    
    static let shard = AlertView()
    
    lazy var baseView = UIView()
    lazy var textLabel = UILabel()
    
    private init() {
        super.init(frame: CGRect.zero)
        self.frame = CGRect(x: 0, y: 0, width: Constant.ScreenWidth, height: Constant.ScreenHeight)
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        self.baseView.backgroundColor = .clear
        self.textLabel.backgroundColor = .gray
        self.textLabel.textColor = .white
        self.textLabel.numberOfLines = 0
        self.textLabel.layer.cornerRadius = 8
        self.textLabel.layer.borderColor = UIColor.clear.cgColor
        self.textLabel.layer.borderWidth = 1
        self.textLabel.layer.masksToBounds = true
        self.textLabel.textAlignment = .center
        self.baseView.translatesAutoresizingMaskIntoConstraints = false
        self.textLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.baseView)
        self.baseView.addSubview(self.textLabel)
        NSLayoutConstraint.activate([
            baseView.topAnchor.constraint(equalTo: self.topAnchor),
            baseView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            baseView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            baseView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            textLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            textLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: AlertViewConstraint.TextLabelMargin),
            textLabel.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: AlertViewConstraint.TextLabelMargin)])
    }
    
    func show(_ text: String) {
        let window = FundamentalUtils.shard.obtainKeyWindow()
        textLabel.text = text
        window?.addSubview(self)
        let time: TimeInterval = 2.0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
            self.removeFromSuperview()
        }
    }
    
}
