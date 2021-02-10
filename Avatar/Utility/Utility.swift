//
//  Utility.swift
//  Avatar
//
//  Created by MohammadReza on 2/11/21.
//

import Foundation
import UIKit
import SystemConfiguration

class Utility {

    func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        guard let defReachibility = defaultRouteReachability else {
            return false
        }
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defReachibility, &flags) == false {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        return ret
    }

    func saveData(inUserDefulat storeObject: Any?, keyOfUserDefault key: String?) {
        let prefs = UserDefaults.standard
        prefs.set(storeObject, forKey: key ?? "")
    }

    func reteriveData(inUserDefulat key: String?) -> Any? {
        let prefs = UserDefaults.standard
        let storedObject = prefs.value(forKey: key ?? "")
        return storedObject
    }
}

enum AppStoryboard: String {
    case Main, Second

    var instance: UIStoryboard {
      return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        return instance.instantiateViewController(withIdentifier: storyboardID) as! T // swiftlint:disable:this force_cast
    }
    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }

}
