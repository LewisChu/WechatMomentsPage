//
//  ObtainHeight.swift
//  WeChatMomentsPage
//
//  Created by BeiBeiLewis ZHU on 2020/12/22.
//  Copyright © 2020 BeiBeiLewis ZHU. All rights reserved.
//

import UIKit

class ObtainHeight: UIView {

    static let shared = ObtainHeight()
    
    func getHeightViaWidth( _ fontSize: CGFloat,_ wid: CGFloat,_ str: String) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let size = CGSize(width: wid, height: CGFloat.greatestFiniteMagnitude)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping;
        
        let attributes = [NSAttributedString.Key.font: font, NSAttributedString.Key.paragraphStyle:paragraphStyle.copy()]
        
        let rect = str.trimmingCharacters(in: .whitespaces).boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: attributes, context:nil)
        return rect.size.height
    }

}
