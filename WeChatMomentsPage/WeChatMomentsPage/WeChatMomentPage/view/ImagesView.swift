//
//  ImagesView.swift
//  WeChatMomentsPage
//
//  Created by BeiBeiLewis ZHU on 2020/12/22.
//  Copyright © 2020 BeiBeiLewis ZHU. All rights reserved.
//

import UIKit

class ImagesView: UIView {
    
    private struct ImageViewConstant {
        static let ImageDefaultTag = 1000
    }
    
    lazy var imagesUrlArray: [String] = []
    lazy var imagesViewArray: [UIImageView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        for i in 0..<9{
            let imageView = UIImageView(frame: CGRect.zero)
            imageView.tag = ImageViewConstant.ImageDefaultTag + i
            self.addSubview(imageView)
            self.imagesViewArray.append(imageView)
        }
        
        
    }
    
    func setDatas(_ imageArray: [String]){
        self.imagesUrlArray = imageArray
        for tempImgView in self.imagesViewArray {
            tempImgView.isHidden = true
        }
        let imgWidthAndHeight: CGFloat = (self.frame.size.width - 20)/3
        if imagesUrlArray.count == 1 {
            self.setImagesViewHeight(hei: imgWidthAndHeight * 2)
            var imgView = UIImageView()
            imgView.frame = CGRect(x: 0, y: 0, width: 200, height: 100 )
            imgView = self.viewWithTag(ImageViewConstant.ImageDefaultTag) as! UIImageView
            imgView.isHidden = false
            DownloadAndCacheImage.shard.obtainImage(imagesUrlArray[0]) { (data, url) in
                if let imageData = data{
                    let img = UIImage(data: imageData)
                    let newImg = self.resizeImage(image: img!, newHeight: imgWidthAndHeight * 2)
                    imgView.frame = CGRect(x: 0, y: 0, width: newImg.size.width, height: newImg.size.height)
                   
                    imgView.image = newImg
                    imgView.contentMode = .scaleAspectFit
                    imgView.clipsToBounds = true
                    self.addSubview(imgView)
                }
            }
        }else if imagesUrlArray.count > 1{
            let totalRow = Int((imagesUrlArray.count - 1)/3) + 1
            self.setImagesViewHeight(hei: imgWidthAndHeight * CGFloat(totalRow) + CGFloat((totalRow>1 ? (totalRow - 1)*10 : 0)))
            
            for i in 0..<imagesUrlArray.count {
                let column = i%3
                let row = Int(i/3)
                var imgView = UIImageView()
                imgView = self.viewWithTag(ImageViewConstant.ImageDefaultTag + i) as! UIImageView
                imgView.isHidden = false
                imgView.frame = CGRect(x: CGFloat(column) * (imgWidthAndHeight + 10), y: CGFloat(row) * (imgWidthAndHeight + 10), width: imgWidthAndHeight, height: imgWidthAndHeight)
                
                DownloadAndCacheImage.shard.obtainImage(imagesUrlArray[i]) { (data, url) in
                    if let imageData = data{
                        let img = UIImage(data: imageData)
                        imgView.image = img
                        imgView.contentMode = .scaleAspectFill
                        imgView.clipsToBounds = true
                        self.addSubview(imgView)
                    }
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func resizeImage(image: UIImage, newHeight: CGFloat) -> UIImage {
        let scale = newHeight / image.size.height
        var newWidth = image.size.width * scale
        if image.size.width * scale > self.frame.size.width {
            newWidth = self.frame.size.width
        }
        UIGraphicsBeginImageContext(CGSize(width:newWidth, height:newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    func setImagesViewHeight(hei: CGFloat) {
        var tempFrame =  self.frame
        tempFrame.size.height = hei
        self.frame = tempFrame
    }
    
}
