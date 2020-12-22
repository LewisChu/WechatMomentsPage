//
//  DictionaryConvertToModel.swift
//  WeChatMomentsPage
//
//  Created by BeiBeiLewis ZHU on 2020/12/22.
//  Copyright © 2020 BeiBeiLewis ZHU. All rights reserved.
//

import UIKit

// MARK: Dictionary convert to model
struct DictionaryDecoder {
    // single dictionary convert to model
    public static func decode<T> (_ type: T.Type, param: [String: Any]) -> T? where T: Decodable {
        guard let jsonData = self.getJsonData(with: param) else {
            return nil
        }
        guard let model = try? JSONDecoder().decode(type, from: jsonData) else {
            return nil
        }
        return model
    }
    
    // 多个字典转模型
    public static func decode<T> (_ type: T.Type, array: [[String: Any]]) -> [T]? where T: Decodable {
        if let data = self.getJsonData(with: array) {
            if let models = try? JSONDecoder().decode([T].self, from: data){
                return models
            }
        }
        return nil
    }
    
    
    
    private static func getJsonData(with param: Any) -> Data? {
        if !JSONSerialization.isValidJSONObject(param) {
            return nil
        }
        guard let data = try? JSONSerialization.data(withJSONObject: param, options: []) else {
            return nil
        }
        return data
    }
}
