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
        static let UsernameHeight = CGFloat(20)
    }
    
    lazy var mainView = UIView()
    lazy var profileimage = UIImageView()
    lazy var usernameLabel = UILabel()
    lazy var avatarImage = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.mainView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        self.mainView.backgroundColor = UIColor.white
        
        self.avatarImage.frame = CGRect(x: Constant.ScreenWidth - HeaderViewConstant.AvatarRightMargin - HeaderViewConstant.AvatarImageWidth, y: Constant.HeaderViewHeight - HeaderViewConstant.AvatarImageWidth, width: HeaderViewConstant.AvatarImageWidth, height: HeaderViewConstant.AvatarImageWidth)
        self.avatarImage.layer.borderWidth = HeaderViewConstant.AvatarBorder
        self.avatarImage.layer.cornerRadius = HeaderViewConstant.AvatarCornerRadius
        self.avatarImage.layer.borderColor = UIColor.clear.cgColor
        self.avatarImage.contentMode = .scaleAspectFill
        
        self.profileimage.frame = CGRect(x: 0, y: 0, width: Constant.ScreenWidth, height: HeaderViewConstant.ProfileImageHeight)
        self.usernameLabel.frame = CGRect(x: 0, y: Constant.HeaderViewHeight - HeaderViewConstant.AvatarImageWidth + 10, width: Constant.ScreenWidth - 36 - HeaderViewConstant.AvatarImageWidth , height: HeaderViewConstant.UsernameHeight)
        self.usernameLabel.textAlignment = .right
        self.usernameLabel.font = UIFont.systemFont(ofSize: 20)
        self.usernameLabel.textColor = UIColor.white
        self.profileimage.image = UIImage(named: "placeholderImg")
        self.addSubview(self.mainView)
        self.mainView.addSubview(self.profileimage)
        self.mainView.addSubview(self.avatarImage)
        self.mainView.addSubview(self.usernameLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
