//
//  AvatarApi.swift
//  Avatar
//
//  Created by MohammadReza on 2/11/21.
//

import Foundation

typealias AvatarServiceCompletion = (Data?, AvatarList?, ErrorMessageModel?) -> Void
typealias AvatarDetailsServiceCompletion = (Data?, Details?, ErrorMessageModel?) -> Void

protocol AvatarServiceProtocol {
    func getAvatarList(completion: @escaping AvatarServiceCompletion)
    func getAvatarDetails(completion: @escaping AvatarDetailsServiceCompletion)
}

class AvatarApi: BaseSDK {
    let avatarListURL = "/?apikey=4f588b70&s=avatar"
    let avatarDetailsURL = "/?i=tt0499549&apikey=4f588b70"
}

extension AvatarApi: AvatarServiceProtocol {
    func getAvatarList(completion: @escaping AvatarServiceCompletion) {
        NetworkingClient.shared.executeGETrequest(makeURL(url: avatarListURL)) { (response, error) in
            if error == nil {
                do {
                    if let data = response {
                        let decoded = try self.decoder.decode(AvatarList.self, from: data)
                        completion(data, decoded, nil)
                    } else {
                        completion(nil, nil, ErrorMessageModel(title: "error".getString(), message: "emptyData".getString()))
                    }
                } catch {
                    completion(nil, nil, ErrorMessageModel(title: "error".getString(), message: "emptyData".getString()))
                }
            } else {
                completion(nil, nil, ErrorMessageModel(title: "error".getString(), message: "serverError".getString()))
            }
        }
    }

    func getAvatarDetails(completion: @escaping AvatarDetailsServiceCompletion) {
        NetworkingClient.shared.executeGETrequest(makeURL(url: avatarDetailsURL)) { (response, error) in
            if error == nil {
                do {
                    if let data = response {
                        let decoded = try self.decoder.decode(Details.self, from: data)
                        completion(data, decoded, nil)
                    } else {
                        completion(nil, nil, ErrorMessageModel(title: "error".getString(), message: "emptyData".getString()))
                    }
                } catch {
                    completion(nil, nil, ErrorMessageModel(title: "error".getString(), message: "emptyData".getString()))
                }
            } else {
                completion(nil, nil, ErrorMessageModel(title: "error".getString(), message: "serverError".getString()))
            }
        }
    }
}
