//
//  UserAPI.swift
//  CocoTalk
//
//  Created by byunghak on 2022/02/09.
//

import Foundation
import Moya

enum UserAPI {
    case fetchMyProfile(_ token: String)
    case fetchFriends(_ token: String)
}

extension UserAPI: TargetType {
    var baseURL: URL {
        return .baseURL
    }
    
    var path: String {
        switch self {
        case .fetchMyProfile(_):
            return "/user/token"
        case .fetchFriends(_):
            return "/user/friends"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchMyProfile(_):
            return .get
        case .fetchFriends(_):
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .fetchMyProfile(_):
            return .requestPlain
        case .fetchFriends(_):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        var parameters: [String : String] = ["Content-type": "application/json"]
        
        switch self {
        case .fetchMyProfile(let token), .fetchFriends(let token):
            parameters["X-ACCESS-TOKEN"] = token
        }
        
        return parameters
    }
    
}