//
//  DownloadAndCacheImage.swift
//  WeChatMomentsPage
//
//  Created by BeiBeiLewis ZHU on 2020/12/22.
//  Copyright © 2020 BeiBeiLewis ZHU. All rights reserved.
//

import UIKit


let MomentsImagesPath = "/Documents/MomentsPhotoCache/"

class DownloadAndCacheImage: NSObject {
    
    static let shard: DownloadAndCacheImage = DownloadAndCacheImage()
    var cache = NSCache<AnyObject, AnyObject>()
    func obtainImage(_ url: String, complete: @escaping (_ data: Data?, _ url: String) -> ()) {
        DispatchQueue.global(qos: .userInitiated).async {[weak self] in
            // firstly: find form Cache
            var data: Data? = self?.cache.object(forKey: self?.getImageName(filePath: url) as AnyObject) as? Data
            if let resultData = data {
                DispatchQueue.main.async {
                    complete(resultData, url)
                }
                return
            }
            
            // Second: find from local
            data = self?.readImageFromSandbox(fileName: url)
            if data != nil {
                DispatchQueue.main.async {
                    complete(data, url)
                }
                return
            }
            
            // last: download
            do {
                let imgUrl = URL(string: url)
                data = try Data(contentsOf: imgUrl!)
                DispatchQueue.main.async {
                    complete(data, url)
                }
                if data != nil {
                    // write to Cache
                    self?.whiteImageToCache(fileName: url, data: data!)
                    // write to local
                    self?.writeImageToSandbox(fileName: url, data: data!)
                }
                return
            } catch let error {
                print(error.localizedDescription)
                return
            }
        }
    }
    
    // write to Cache
    private func whiteImageToCache(fileName: String, data: Data) {
        let key = self.getImageName(filePath: fileName)
        self.cache.setObject(data as AnyObject, forKey: key as AnyObject)
    }
    
    // write to local
    private func writeImageToSandbox(fileName: String, data: Data) {
        let path: String = NSHomeDirectory() + MomentsImagesPath
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: path){
            try? fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }
        
        let imagePath = path + getImageName(filePath: fileName)
        
        do {
            try data.write(to: URL(fileURLWithPath: imagePath))
        } catch let error  {
            print(error.localizedDescription)
        }
    }
    
    // find for local sandbox
    private func readImageFromSandbox(fileName: String) -> Data? {
        let fileManager = FileManager.default
        let imageName = getImageName(filePath: fileName)
        let urlsForDocDirectory = fileManager.urls(for: .documentDirectory, in:.userDomainMask)
        let docPath = urlsForDocDirectory[0]
        let file = docPath.appendingPathComponent(MomentsImagesPath + imageName)
        
        do {
            let readHandler = try FileHandle(forReadingFrom:file)
            let data = readHandler.readDataToEndOfFile()
            return data
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    // generate image name via URL string
    private func getImageName(filePath: String) -> String {
        let data = filePath.data(using: String.Encoding.utf8, allowLossyConversion: true)
        var baseString = data?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: UInt(0)))
        baseString = baseString?.replacingOccurrences(of: "=", with: "")
            .replacingOccurrences(of: "+", with: "")
            .replacingOccurrences(of: "/", with: "")
        // get prefix15 and suffix 20
        return String(baseString!.prefix(15) + baseString!.suffix(20) + filePath.suffix(4))
    }
}
