//
//  CommentView.swift
//  WeChatMomentsPage
//
//  Created by BeiBeiLewis ZHU on 2020/12/22.
//  Copyright © 2020 BeiBeiLewis ZHU. All rights reserved.
//

import UIKit


protocol ClickSendDelegate: NSObjectProtocol {
    func clickSendButton()
}

class CommentView: UIView {
    private struct CommentViewConstant {
        static let CommentTextFieldLeading = CGFloat(10)
        static let CommentTextFieldTop = CGFloat(5)
        static let CommentTextFieldWidth = Constant.ScreenWidth - 80
        static let CommentTextFieldHeight = CGFloat(30)
        static let SendButtonLeading = Constant.ScreenWidth - 70
        static let SendButtonTop = CGFloat(5)
        static let SendButtonWidth = CGFloat(60)
        static let SendButtonHeight = CGFloat(30)
    }
    
    
    lazy var commentTextField = UITextField()
    lazy var sendButton = UIButton()
    
    weak var delegate: ClickSendDelegate?
    
    init() {
        super.init(frame: CGRect.zero)
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func setupUI() {
        self.frame = CGRect(x: 0, y: 0, width: Constant.ScreenWidth, height: 40)
        self.backgroundColor = UIColor(red: 241.0/255, green: 241/255, blue: 241/255, alpha: 1)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1).cgColor
        
        self.commentTextField.translatesAutoresizingMaskIntoConstraints = false
        self.sendButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(commentTextField)
        self.addSubview(sendButton)
        
        NSLayoutConstraint.activate([
            self.commentTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: CommentViewConstant.CommentTextFieldLeading),
            self.commentTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: CommentViewConstant.CommentTextFieldTop),
            self.commentTextField.widthAnchor.constraint(equalToConstant: CommentViewConstant.CommentTextFieldWidth),
            self.commentTextField.heightAnchor.constraint(equalToConstant: CommentViewConstant.CommentTextFieldHeight),
            self.sendButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: CommentViewConstant.SendButtonLeading),
            self.sendButton.topAnchor.constraint(equalTo: self.topAnchor, constant: CommentViewConstant.SendButtonTop),
            self.sendButton.widthAnchor.constraint(equalToConstant: CommentViewConstant.SendButtonWidth),
            self.sendButton.heightAnchor.constraint(equalToConstant: CommentViewConstant.SendButtonHeight)])
        
        
        self.commentTextField.placeholder = "comment"
        self.commentTextField.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1)
        self.commentTextField.layer.cornerRadius = 5
        self.commentTextField.layer.masksToBounds = true
        self.commentTextField.layer.borderWidth = 1
        self.commentTextField.layer.borderColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1).cgColor
        self.commentTextField.contentVerticalAlignment = .center
        self.sendButton.setTitle("send", for: .normal)
        self.sendButton.layer.borderWidth = 1
        self.sendButton.layer.cornerRadius = 5
        self.sendButton.layer.masksToBounds = true
        self.sendButton.layer.borderColor = UIColor.HexColor(0x45a15c).cgColor
        self.sendButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        self.sendButton.setTitleColor(UIColor.white, for: .normal)
        self.sendButton.backgroundColor = UIColor.HexColor(0x45a15c)
        
        self.sendButton.addTarget(self, action: #selector(sendComment), for:.touchUpInside)
    }
    
    @objc func sendComment() {
        self.delegate?.clickSendButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

 

