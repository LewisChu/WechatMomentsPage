//
//  Extension.swift
//  WeChatMomentsPage
//
//  Created by BeiBeiLewis ZHU on 2020/12/22.
//  Copyright © 2020 BeiBeiLewis ZHU. All rights reserved.
//

import UIKit

extension UIColor {
     class func HexColor(_ hexColor: Int32 ) -> UIColor {
         let r = CGFloat(((hexColor & 0x00FF0000) >> 16)) / 255.0
         let g = CGFloat(((hexColor & 0x0000FF00) >> 8)) / 255.0
         let b = CGFloat(hexColor & 0x000000FF) / 255.0
         return UIColor(red: r, green: g, blue: b, alpha: 1.0)
     }
 }
