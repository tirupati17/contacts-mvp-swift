//
//  GKAPIRequest+Contacts.swift
//  Contacts
//
//  Created by Tirupati Balan on 15/04/19.
//  Copyright © 2019 Tirupati Balan. All rights reserved.
//


extension GKAPIRequest {
    class func contactList(_ success : ((JSON) -> Void)?, failure : ((Error) -> Void)?) {
        let apiRequest = GKAPIRequest.init(requestType: GKAPIRequestType.APIRequestContactList)
        let urlString = GKAPIStringUrl.contactEndpoint()
        
        apiRequest.requestWithUrlString(urlString,
                                        requestMethod: GKRequestMethod.RequestMethodGet,
                                        params: [:],
                                        data : nil,
                                        success : success,
                                        failure : failure)
    }
    
    class func contactDetail(_ id : String, success : ((JSON) -> Void)?, failure : ((Error) -> Void)?) {
        let apiRequest = GKAPIRequest.init(requestType: GKAPIRequestType.APIRequestContactDetail)
        let urlString = GKAPIStringUrl.contactWithIdEndpoint(id)
        
        apiRequest.requestWithUrlString(urlString,
                                        requestMethod: GKRequestMethod.RequestMethodGet,
                                        params: [:],
                                        data : nil,
                                        success : success,
                                        failure : failure)
    }
    
    class func contactCreate(_ success : ((JSON) -> Void)?, failure : ((Error) -> Void)?) {
        let apiRequest = GKAPIRequest.init(requestType: GKAPIRequestType.APIRequestContactCreate)
        let urlString = GKAPIStringUrl.contactEndpoint()
        
        apiRequest.requestWithUrlString(urlString,
                                        requestMethod: GKRequestMethod.RequestMethodPost,
                                        params: [:],
                                        data : nil,
                                        success : success,
                                        failure : failure)
    }
    
    class func contactUpdate(_ id : String, success : ((JSON) -> Void)?, failure : ((Error) -> Void)?) {
        let apiRequest = GKAPIRequest.init(requestType: GKAPIRequestType.APIRequestContactUpdate)
        let urlString = GKAPIStringUrl.contactWithIdEndpoint(id)
        
        apiRequest.requestWithUrlString(urlString,
                                        requestMethod: GKRequestMethod.RequestMethodPut,
                                        params: [:],
                                        data : nil,
                                        success : success,
                                        failure : failure)
    }
    
    class func contactDelete(_ id : String, success : ((JSON) -> Void)?, failure : ((Error) -> Void)?) {
        let apiRequest = GKAPIRequest.init(requestType: GKAPIRequestType.APIRequestContactDelete)
        let urlString = GKAPIStringUrl.contactWithIdEndpoint(id)
        
        apiRequest.requestWithUrlString(urlString,
                                        requestMethod: GKRequestMethod.RequestMethodDelete,
                                        params: [:],
                                        data : nil,
                                        success : success,
                                        failure : failure)
    }
}

