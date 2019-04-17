//
//  GKAPIRequest.swift
//  Contacts
//
//  Created by Tirupati Balan on 15/04/19.
//  Copyright © 2019 Tirupati Balan. All rights reserved.
//


typealias JSON = AnyObject
typealias JSONDictionary = Dictionary<String, JSON>
typealias JSONArray = Array<JSON>

class GKAPIRequest {
    var urlString: String?
    
    var contentType: String = ""
    var mimeType: String = ""
    var fileName: String = ""
    var boundary: String = ""
    
    var params: [String: Any] = [:]
    var requestType: GKAPIRequestType?
    var requestMethod: GKRequestMethod?
    var dataRequest: URLSessionTask!
    
    var completed:Bool? = false
    var data: Data? = nil
    
    init(requestType : GKAPIRequestType? = nil) {
        self.requestType = requestType
    }
    
    func performRequest() {
        self.performRequestWith(success: nil, failure: nil)
    }
    
    func performRequestWith(success:((JSON) -> Void)!, failure:((Error) -> Void)!) {
        self.dataRequest = GKURLConnectionManager.sharedInstance.connectionWithRequest(self, success: success, failure: failure)
    }
    
    func cancelRequest() {
        self.dataRequest.cancel()
    }
    
    func requestWithUrlString(_ urlString:String? = "", requestMethod: GKRequestMethod? = nil, params:[String:Any]? = [:], data:Data?, success:((JSON) -> Void)?, failure:((Error) -> Void)?) {
        self.urlString = urlString
        self.params = params!
        self.requestMethod = requestMethod
        self.data = data
        self.performRequestWith(success: success!, failure: failure)
    }
    
}
