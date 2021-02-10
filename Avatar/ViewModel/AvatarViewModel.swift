//
//  AvatarViewModel.swift
//  Avatar
//
//  Created by MohammadReza on 2/11/21.
//

import Foundation

typealias AvatarCompletion = (AvatarList?, ErrorMessageModel?) -> Void
typealias AvatarDetailsCompletion = (Details?, ErrorMessageModel?) -> Void

protocol AvatarProtocol {
    func getAvatarList(completion: @escaping AvatarCompletion)
    func getAvatarDetails(completion: @escaping AvatarDetailsCompletion)
}

class AvatarViewModel {

    fileprivate var service: AvatarServiceProtocol!
    fileprivate var decoder = JSONDecoder()
    fileprivate var encoder = JSONEncoder()
    fileprivate var isAvatarListRecieved = false
    fileprivate var isAvatarDetailsReceived = false

    init(service: AvatarServiceProtocol = AvatarApi()) {
        self.service = service
    }

    func saveAvatarList(list: Data) {
        isAvatarListRecieved = true
        Utility().saveData(inUserDefulat: isAvatarListRecieved, keyOfUserDefault: "isAvatarListRecieved")
        Utility().saveData(inUserDefulat: list, keyOfUserDefault: "AvatarList")
    }

    func retereiveAvatarList() -> AvatarList? {
        if let dataAvatarList = Utility().reteriveData(inUserDefulat: "AvatarList") as? Data {
            do {
                let decoded = try decoder.decode(AvatarList.self, from: dataAvatarList)
                return decoded
            } catch {
                return nil
            }
        }
        return nil
    }

    func saveAvatarDetails(details: Data) {
        isAvatarDetailsReceived = true
        Utility().saveData(inUserDefulat: isAvatarDetailsReceived, keyOfUserDefault: "isAvatarDetailsReceived")
        Utility().saveData(inUserDefulat: details, keyOfUserDefault: "AvatarDetails")
    }

    func retereiveAvatarDetails() -> Details? {
        if let dataAvatarDetails = Utility().reteriveData(inUserDefulat: "AvatarDetails") as? Data {
            do {
                let decoded = try decoder.decode(Details.self, from: dataAvatarDetails)
                return decoded
            } catch {
                return nil
            }
        }
        return nil
    }

}

extension AvatarViewModel: AvatarProtocol {
    func getAvatarList(completion: @escaping AvatarCompletion) {
        if let isAvatarListSaved = Utility().reteriveData(inUserDefulat: "isAvatarListRecieved") as? Bool {
            if isAvatarListSaved {
                completion(retereiveAvatarList(), nil)
            } else {
                if Utility().isConnectedToNetwork() {
                    service.getAvatarList { (data, avatarList, error) in
                        if error == nil {
                            self.saveAvatarList(list: data!)
                            completion(avatarList, nil)
                        } else {
                            completion(nil, error)
                        }
                    }
                } else {
                    completion(nil, ErrorMessageModel(title: "error".getString(), message: "isNotConnected".getString()))
                }
            }
        } else {
            if Utility().isConnectedToNetwork() {
                service.getAvatarList { (data, avatarList, error) in
                    if error == nil {
                        self.saveAvatarList(list: data!)
                        completion(avatarList, nil)
                    } else {
                        completion(nil, error)
                    }
                }
            } else {
                completion(nil, ErrorMessageModel(title: "error".getString(), message: "isNotConnected".getString()))
            }
        }
    }

    func getAvatarDetails(completion: @escaping AvatarDetailsCompletion) {
        if let isAvatarDetailsSaved = Utility().reteriveData(inUserDefulat: "isAvatarDetailsReceived") as? Bool {
            if isAvatarDetailsSaved {
                completion(retereiveAvatarDetails(), nil)
            } else {
                if Utility().isConnectedToNetwork() {
                    service.getAvatarDetails { (data, details, error) in
                        if error == nil {
                            self.saveAvatarDetails(details: data!)
                            completion(details, nil)
                        } else {
                            completion(nil, error)
                        }
                    }
                } else {
                    completion(nil, ErrorMessageModel(title: "error".getString(), message: "isNotConnected".getString()))
                }
            }
        } else {
            if Utility().isConnectedToNetwork() {
                service.getAvatarDetails{ (data, details, error) in
                    if error == nil {
                        self.saveAvatarDetails(details: data!)
                        completion(details, nil)
                    } else {
                        completion(nil, error)
                    }
                }
            } else {
                completion(nil, ErrorMessageModel(title: "error".getString(), message: "isNotConnected".getString()))
            }
        }
    }
}

