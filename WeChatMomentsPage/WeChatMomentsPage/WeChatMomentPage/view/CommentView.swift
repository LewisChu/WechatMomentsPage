//
//  CommentView.swift
//  WeChatMomentsPage
//
//  Created by BeiBeiLewis ZHU on 2020/12/22.
//  Copyright © 2020 BeiBeiLewis ZHU. All rights reserved.
//

import UIKit

class CommentView: UIView {
    
    let commentTextField = UITextField()
    let sendBtn = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1).cgColor
        
        self.commentTextField.frame = CGRect(x: 10, y: 5, width: Constant.ScreenWidth - 80, height: 30)
        self.commentTextField.placeholder = "comment"
        self.commentTextField.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1)
//        self.commentTextField.setValue(UIColor(red: 160/255, green: 160/255, blue: 154/255, alpha: 1), forKeyPath: "_placeholderLabel.textColor")
//        self.commentTextField.setValue(UIFont.systemFont(ofSize: 13), forKeyPath: "_placeholderLabel.font")
        self.commentTextField.layer.cornerRadius = 5
        self.commentTextField.layer.masksToBounds = true
        self.commentTextField.layer.borderWidth = 1
        self.commentTextField.layer.borderColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1).cgColor
        self.commentTextField.contentVerticalAlignment = .bottom
        self.sendBtn.frame = CGRect(x: Constant.ScreenWidth - 70, y: 5, width: 60, height: 30)
        self.sendBtn.setTitle("send", for: .normal)
        
        self.sendBtn.layer.borderWidth = 1
        self.sendBtn.layer.cornerRadius = 5
        self.sendBtn.layer.masksToBounds = true
        self.sendBtn.layer.borderColor = UIColor.HexColor(0x45a15c).cgColor
        self.sendBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        self.sendBtn.setTitleColor(UIColor.white, for: .normal)
        self.sendBtn.backgroundColor = UIColor.HexColor(0x45a15c)
        
        self.addSubview(commentTextField)
        self.addSubview(sendBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

 

