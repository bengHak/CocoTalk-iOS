//
//  RoomAPI.swift
//  CocoTalk
//
//  Created by byunghak on 2022/02/09.
//

import Foundation
import Moya

enum RoomAPI {
    case fetchPrevMessages(_ token: String, roomId: String, bundleId: String, count: Int)
    case fetchInitialMessages(_ token: String, roomId: String, count: Int)
    case fetchRoomInfo(_ token: String, roomId: String)
    case fetchRooms(_ token: String)
    case checkRoomExist(_ token: String, memberId: String)
    case postMediaFile(_ token: String, roomId: String, mediaFile: Data, mediaThumbnail: Data)
}

extension RoomAPI: TargetType {
    var baseURL: URL {
        .baseURL
    }
    
    var path: String {
        switch self {
        case .fetchRooms(_):
            return "/chat/rooms/list"
        case .checkRoomExist(_, memberId: let memberId):
            return "/chat/rooms/private/\(memberId)"
        case .fetchRoomInfo(_, let roomId):
            return "/chat/rooms/\(roomId)"
        case .fetchInitialMessages(_, let roomId,_):
            return "/chat/rooms/\(roomId)/tail/"
        case .fetchPrevMessages(_,_,_,_):
            return "/chat/messages"
        case .postMediaFile(_,let roomId,_,_):
            return "/chat/messages/file"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchRooms(_):
            return .get
        case .checkRoomExist(_,_):
            return .get
        case .fetchRoomInfo(_,_):
            return .get
        case .fetchInitialMessages(_,_,_):
            return .get
        case .fetchPrevMessages(_,_,_,_):
            return .get
        case .postMediaFile(_,_,_,_):
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .fetchRooms(_):
            return .requestPlain
        case .checkRoomExist(_,_):
            return .requestPlain
        case .fetchRoomInfo(_,_):
            return .requestPlain
        case .fetchInitialMessages(_,_,let count):
            return .requestParameters(parameters: ["count": count], encoding: URLEncoding.queryString)
        case .fetchPrevMessages(_, let roomId, let bundleId, let count):
            return .requestParameters(parameters: ["roomId": roomId, "bundleId": bundleId, "count": "\(count)"],
                                      encoding: URLEncoding.queryString)
        case .postMediaFile(_, let roomId, let mediaData,let thumbnailData):
            var formData: [Moya.MultipartFormData] = []
            formData.append(Moya.MultipartFormData(provider: .data(mediaData), name: "messageFile", fileName: "messageFile.jpeg", mimeType: "image/jpeg"))
            formData.append(Moya.MultipartFormData(provider: .data(thumbnailData), name: "messageFileThumb", fileName: "messageFileThumb.jpeg", mimeType: "image/jpeg"))
            
            let roomIdData = roomId.data(using: String.Encoding.utf8) ?? Data()
            formData.append(Moya.MultipartFormData(provider: .data(roomIdData), name: "roomId"))
            return .uploadMultipart(formData)
        }
    }
    
    var headers: [String : String]? {
        var parameters: [String : String] = ["Content-type": "application/json"]
        
        switch self {
        case .fetchRooms(let token):
            parameters["X-ACCESS-TOKEN"] = token
            break
        case .checkRoomExist(let token, _):
            parameters["X-ACCESS-TOKEN"] = token
            break
        case .fetchRoomInfo(let token,_):
            parameters["X-ACCESS-TOKEN"] = token
            break
        case .fetchInitialMessages(let token,_,_):
            parameters["X-ACCESS-TOKEN"] = token
            break
        case .fetchPrevMessages(let token,_,_,_):
            parameters["X-ACCESS-TOKEN"] = token
            break
        case .postMediaFile(let token,_,_,_):
            parameters["Content-type"] = "multipart/form-data"
            parameters["X-ACCESS-TOKEN"] = token
            break
        }
        
        return parameters
    }
    
    
}
