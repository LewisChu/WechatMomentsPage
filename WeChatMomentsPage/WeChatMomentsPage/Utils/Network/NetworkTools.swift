//
//  NetworkTools.swift
//  WeChatMomentsPage
//
//  Created by BeiBeiLewis ZHU on 2020/12/21.
//  Copyright © 2020 BeiBeiLewis ZHU. All rights reserved.
//

import AFNetworking

enum HTTPRequestType : Int{
    case GET = 0
    case POST
}

class NetworkTools: AFHTTPSessionManager {
    static let shareInstance : NetworkTools = {
        let tools = NetworkTools()
        tools.requestSerializer = AFJSONRequestSerializer()
        tools.responseSerializer = AFJSONResponseSerializer()
        tools.requestSerializer.setValue("application/json,text/html", forHTTPHeaderField: "Accept")
        tools.requestSerializer.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        return tools
        }()
}

extension NetworkTools {
    func request(methodType : HTTPRequestType, urlString : String, parameters : [String : Any]?, finished: @escaping (_ results : Any?, _ statusCode: Int?, _ error : Error?)-> ())  {
        // 1. request is successful
        let successCallBack = {(task :URLSessionDataTask, result : Any) in
            var statusCodeTemp: Int?
            let urlResponse = task.response
            if let urlResponseTemp = urlResponse as? HTTPURLResponse {
                statusCodeTemp = urlResponseTemp.statusCode
            }
            finished(result, statusCodeTemp, nil)
        }
        // 2. request is failure
        let failureCallBack = {(task : URLSessionDataTask?, error :Error) in
            var statusCodeTemp: Int?
            let urlResponse = task?.response
            if let urlResponseTemp = urlResponse as? HTTPURLResponse {
                statusCodeTemp = urlResponseTemp.statusCode
            }
            finished(nil, statusCodeTemp, error)
        }
        if methodType == .GET {
            // get请求
            get(urlString, parameters: parameters, headers: nil, progress: nil, success: successCallBack, failure: failureCallBack)
        }else if methodType == .POST {
            // post请求
            post(urlString, parameters: parameters, headers: nil, progress: nil, success: successCallBack, failure: failureCallBack)
        }
    }
    
}
