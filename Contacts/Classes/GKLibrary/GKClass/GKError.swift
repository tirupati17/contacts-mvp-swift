//
//  GKError.swift
//  Contacts
//
//  Created by Tirupati Balan on 15/04/19.
//  Copyright © 2019 Tirupati Balan. All rights reserved.
//


protocol LocalizedDescriptionError: Error {
    var localizedDescription: String { get }
}

public enum GKError : LocalizedDescriptionError {
    case invalidArray(model: String)
    case invalidDictionary(model: String)
    case customError(message: String)
    
    var localizedDescription: String {
        switch self {
            case .invalidArray(model: let model):
                return "\(model) has an invalid array"
            case .invalidDictionary(model: let model):
                return "\(model) has an invalid dictionary"
            case .customError(message: let message):
                return "\(message)"
        }
    }
}
