//
//  WeChatMomentsCell.swift
//  WeChatMomentsPage
//
//  Created by BeiBeiLewis ZHU on 2020/12/22.
//  Copyright © 2020 BeiBeiLewis ZHU. All rights reserved.
//

import UIKit

class WeChatMomentsCell: UITableViewCell {
    
    private struct CellConstant {
        static let Zero = CGFloat(0)
        static let ImagesWidth = Constant.ScreenWidth - 120
        static let ImagesHeight = CGFloat(100)
        static let OneImageHeight = (Constant.ScreenWidth - 120)*2/3
        static let TwoToThreeImagesHeight = (Constant.ScreenWidth - 120)/3
        static let FourToSixImagesHeight = (Constant.ScreenWidth - 120)*2/3 + 10
        static let DefaultImagesHeight = (Constant.ScreenWidth - 120) + 20
        static let CommentLeading = CGFloat(8)
        static let CommentWidth = Constant.ScreenWidth - 96
        static let CommentDefaultHeight = CGFloat(18)
        static let CommentLineSpace = CGFloat(4)
        static let CommentSize = CGFloat(13)
        static let NicknameWith = Constant.ScreenWidth - 80
        static let NicknameSize = CGFloat(15)
    }
    
    
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
    
    lazy var images = ImagesView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.images.frame = CGRect(x: CellConstant.Zero, y: CellConstant.Zero, width: CellConstant.ImagesWidth, height: CellConstant.ImagesHeight)
        self.imagesView.addSubview(self.images)
        self.likeAndCommentView.layer.cornerRadius = 4
        self.likeAndCommentView.layer.borderWidth = 1
        self.likeAndCommentView.layer.borderColor = UIColor.clear.cgColor
    }

     
    func setDatas(_ tweetsForm: TweetsForm) {
        // setup avatar
        if let sender = tweetsForm.sender,let avatarUrl = sender.avatar{
            DownloadAndCacheImage.shard.obtainImage(avatarUrl) { (data, url) in
                if let imageData = data {
                    let img = UIImage(data: imageData)
                    self.avatarImgView.image = img
                }
            }
        }

        // setup nickname
        if let sender = tweetsForm.sender,let nick = sender.nick{
            self.nickName.text = nick
        }
         
        // setup content
        if let content = tweetsForm.content{
            self.contentLab.text = content
            let nicknameHeight = ObtainHeight.shared.getHeightViaWidth(CellConstant.NicknameSize, CellConstant.NicknameWith, content)
            self.contentHeight.constant = nicknameHeight
        }else{
            self.contentHeight.constant = CellConstant.Zero
        }
        
        if let tempImages = tweetsForm.images{
            let imgUrlArray = tempImages.filter{ !($0.url?.isEmpty ?? true) }.map{ $0.url ?? "" }
            var imgsHei = CellConstant.Zero
            switch imgUrlArray.count {
            case 0:
                imgsHei = CellConstant.Zero
            case 1:
                imgsHei = CellConstant.OneImageHeight
            case 2..<4:
                imgsHei = CellConstant.TwoToThreeImagesHeight
            case 4..<7:
                imgsHei = CellConstant.FourToSixImagesHeight
            default:
                imgsHei = CellConstant.DefaultImagesHeight
            }
            
            if imgUrlArray.count > 0{
                self.imagesViewHeight.constant = imgsHei
                self.images.setDatas(imgUrlArray)
            }
        }else{
            self.imagesViewHeight.constant = CellConstant.Zero
        }
            
        guard let comments = tweetsForm.comments else{
            self.commentsView.isHidden = true
            return
        }
        
        // setup comments
        var commentsHeight = CellConstant.Zero
        for comment in comments {
            var name = ""
            var commentContent = ""
            var singleComment = ""
            if let sender = comment.sender,let commentsNick = sender.nick{
                name = commentsNick + "："
                
            }
            if let commentsContentTemp = comment.content{
                commentContent = commentsContentTemp
            }
            singleComment = name + commentContent
            let commentLabel =  UILabel(frame: CGRect(x: CellConstant.CommentLeading, y: commentsHeight, width: CellConstant.CommentWidth, height: CellConstant.CommentDefaultHeight))
            commentLabel.font = UIFont.systemFont(ofSize: CellConstant.CommentSize)
            
            let tempCommentHeight = ObtainHeight.shared.getHeightViaWidth(CellConstant.CommentSize, CellConstant.CommentWidth, singleComment)
            var conmentLabelFrame = commentLabel.frame
            conmentLabelFrame.size.height = tempCommentHeight + CellConstant.CommentLineSpace
            commentLabel.frame = conmentLabelFrame
            commentsHeight += commentLabel.frame.size.height + CellConstant.CommentLineSpace
            self.commentsViewHeight.constant = commentsHeight
            self.commentsView.addSubview(commentLabel)
            
            let attrStr = NSMutableAttributedString.init(string: singleComment)
            attrStr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 74/255, green: 83/255, blue: 130/255, alpha: 1) , range:NSRange.init(location:0, length: name.count))
            attrStr.addAttribute(NSAttributedString.Key.foregroundColor, value:UIColor.gray, range:NSRange.init(location:name.count, length: commentContent.count))
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
