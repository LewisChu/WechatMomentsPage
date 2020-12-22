//
//  WeChatMomentsCell.swift
//  WeChatMomentsPage
//
//  Created by BeiBeiLewis ZHU on 2020/12/22.
//  Copyright © 2020 BeiBeiLewis ZHU. All rights reserved.
//

import UIKit

class WeChatMomentsCell: UITableViewCell {
    
    @IBOutlet weak var avatarImgView: UIImageView!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var contentLab: UILabel!
    @IBOutlet weak var imagesView: UIView!
    @IBOutlet weak var commentsView: UIView!
    
    @IBOutlet weak var contentHeight: NSLayoutConstraint!
    @IBOutlet weak var imagesViewHeight: NSLayoutConstraint!
    @IBOutlet weak var commentsViewHeight: NSLayoutConstraint!
    @IBOutlet weak var likeAndCommentView: UIView!
    
    @IBOutlet weak var commentBtn: UIButton!
    
    var images = ImagesView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.images.frame = CGRect(x: 0, y: 0, width: Constant.ScreenWidth - self.avatarImgView.frame.size.width - 40 - 40, height: 100)
        self.imagesView.addSubview(self.images)
        
        self.likeAndCommentView.layer.cornerRadius = 4
        self.likeAndCommentView.layer.borderWidth = 1
        self.likeAndCommentView.layer.borderColor = UIColor.clear.cgColor
    }

     func setDatas(_ tweetsForm: TweetsForm) {
              if let sender = tweetsForm.sender{
                  if let avatarUrl = sender.avatar{
                      DownloadAndCacheImage.shard.obtainImage(avatarUrl) { (data, url) in
                          if let imageData = data{
                              let img = UIImage(data: imageData)
                              self.avatarImgView.image = img
                          }
                      }
                  }
                  if let nick = sender.nick{
                      self.nickName.text = nick
                  }
              }
              
              if let content = tweetsForm.content{
                  self.contentLab.text = content
                  let nickHei = ObtainHeight.shared.getHeightViaWidth(15, Constant.ScreenWidth - 80, content)
                  self.contentHeight.constant = nickHei
              }else{
                  self.contentHeight.constant = 0
              }
              if let tempImages = tweetsForm.images{
                  var imgUrlArray: [String] = []
                  for i in 0..<tempImages.count{
                      if let imgUrl = tempImages[i].url{
                          imgUrlArray.append(imgUrl)
                      }
                  }
                  if imgUrlArray.count>0{
                      var imgsHei = CGFloat(0)
                      if imgUrlArray.count == 1{
                        imgsHei = (Constant.ScreenWidth - 120)*2/3
                      }else if  imgUrlArray.count < 4{
                          imgsHei = (Constant.ScreenWidth - 120)/3
                      }else if imgUrlArray.count < 7 {
                          imgsHei = (Constant.ScreenWidth - 120)*2/3 + 10
                      }else {
                          imgsHei = (Constant.ScreenWidth - 120) + 20
                      }
                      self.imagesViewHeight.constant = imgsHei
                      
                      
                      self.images.setDatas(imgUrlArray)
                  }
              }else{
                  self.imagesViewHeight.constant = 0
              }
              
              
              
              guard let comments = tweetsForm.comments else{
                  self.commentsView.isHidden = true
                  return
              }
              
              var commentsHeight = CGFloat(0)
              for comment in comments {
      //            let comment_view = CommentView()
                  var nameStr = ""
                  var commentsContentStr = ""
                  var commentStr = ""
                  if let sender = comment.sender,let commentsNick = sender.nick{
                      nameStr = commentsNick + "："
                  }
                  if let commentsContent = comment.content{
                      commentsContentStr = commentsContent
                  }
                  commentStr = nameStr + commentsContentStr
                  let commentLabel =  UILabel(frame: CGRect(x: 8, y: commentsHeight, width: Constant.ScreenWidth - self.avatarImgView.frame.size.width - 40 - 16, height: 18))
                  commentLabel.font = UIFont.systemFont(ofSize: 13)
                  
                  let tempCommentHeight = ObtainHeight.shared.getHeightViaWidth(13, Constant.ScreenWidth - self.avatarImgView.frame.size.width - 40 - 16, commentStr)
                  var conmentLabelFrame = commentLabel.frame
                  conmentLabelFrame.size.height = tempCommentHeight + 4
                  commentLabel.frame = conmentLabelFrame
                  commentsHeight += commentLabel.frame.size.height + 4
                  self.commentsViewHeight.constant = commentsHeight
                  self.commentsView.addSubview(commentLabel)
                  
                  let attrStr = NSMutableAttributedString.init(string: commentStr)
                  attrStr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 74/255, green: 83/255, blue: 130/255, alpha: 1) , range:NSRange.init(location:0, length: nameStr.count))
                  attrStr.addAttribute(NSAttributedString.Key.foregroundColor, value:UIColor.gray, range:NSRange.init(location:nameStr.count, length: commentsContentStr.count))
                  commentLabel.attributedText = attrStr
              }
              if commentsHeight == 0 {
                  self.commentsView.isHidden = true
              }
          }
          
       
          
          
          
          override func setSelected(_ selected: Bool, animated: Bool) {
              super.setSelected(selected, animated: animated)
              // Configure the view for the selected state
          }
        
        
        func setImagesViewHeight() {
            var imagesViewFrame = self.imagesView.frame
            imagesViewFrame.size.height = self.images.frame.size.height
            self.imagesView.frame = imagesViewFrame
        }
        
}
