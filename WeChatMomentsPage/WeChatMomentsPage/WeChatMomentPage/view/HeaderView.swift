//
//  HeaderView.swift
//  WeChatMomentsPage
//
//  Created by BeiBeiLewis ZHU on 2020/12/22.
//  Copyright © 2020 BeiBeiLewis ZHU. All rights reserved.
//

import UIKit

class HeaderView: UIView {

    private struct HeaderViewConstant {
        static let AvatarImageWidth = CGFloat(60)
        static let ProfileImageHeight = UIScreen.main.bounds.width * 374/562
        static let AvatarRightMargin = CGFloat(16)
        static let AvatarBorder = CGFloat(1)
        static let AvatarCornerRadius = CGFloat(4)
        static let AvatarLeading = Constant.ScreenWidth - HeaderViewConstant.AvatarRightMargin - HeaderViewConstant.AvatarImageWidth
        static let UsernameHeight = CGFloat(23)
        static let UsernameTopMargin = Constant.HeaderViewHeight - HeaderViewConstant.AvatarImageWidth + 11
        static let UsernameTrailingMargin = -16 - HeaderViewConstant.AvatarImageWidth
    }
    
    lazy var mainView = UIView()
    lazy var profileimage = UIImageView()
    lazy var usernameLabel = UILabel()
    lazy var avatarImage = UIImageView()
    
    
    init() {
        super.init(frame: CGRect.zero)
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    private func setupUI() {
        self.frame = CGRect(x: 0, y: 0, width: Constant.ScreenWidth, height: Constant.HeaderViewHeight)
        self.addSubview(self.mainView)
        self.mainView.addSubview(self.profileimage)
        self.mainView.addSubview(self.avatarImage)
        self.mainView.addSubview(self.usernameLabel)
        
        self.mainView.translatesAutoresizingMaskIntoConstraints = false
        self.profileimage.translatesAutoresizingMaskIntoConstraints = false
        self.avatarImage.translatesAutoresizingMaskIntoConstraints = false
        self.usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.mainView.topAnchor.constraint(equalTo: self.topAnchor),
            self.mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.profileimage.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor),
            self.profileimage.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor),
            self.profileimage.topAnchor.constraint(equalTo: self.mainView.topAnchor),
            self.profileimage.heightAnchor.constraint(equalToConstant: HeaderViewConstant.ProfileImageHeight),
            self.avatarImage.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor, constant: HeaderViewConstant.AvatarLeading),
            self.avatarImage.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor),
            self.avatarImage.widthAnchor.constraint(equalToConstant: HeaderViewConstant.AvatarImageWidth),
            self.avatarImage.heightAnchor.constraint(equalToConstant: HeaderViewConstant.AvatarImageWidth),
            self.usernameLabel.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor),
            self.usernameLabel.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor, constant: HeaderViewConstant.UsernameTrailingMargin),
            self.usernameLabel.topAnchor.constraint(equalTo: self.mainView.topAnchor, constant: HeaderViewConstant.UsernameTopMargin),
            self.usernameLabel.heightAnchor.constraint(equalToConstant: HeaderViewConstant.UsernameHeight)])
        
        self.mainView.backgroundColor = UIColor.white
        self.avatarImage.layer.borderWidth = HeaderViewConstant.AvatarBorder
        self.avatarImage.layer.cornerRadius = HeaderViewConstant.AvatarCornerRadius
        self.avatarImage.layer.borderColor = UIColor.clear.cgColor
        self.avatarImage.contentMode = .scaleAspectFill
        self.usernameLabel.textAlignment = .right
        self.usernameLabel.font = UIFont.systemFont(ofSize: 22)
        self.usernameLabel.textColor = UIColor.white
        self.profileimage.backgroundColor = .gray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
