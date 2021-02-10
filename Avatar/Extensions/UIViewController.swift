//
//  UIViewController.swift
//  Avatar
//
//  Created by MohammadReza on 2/11/21.
//

import Foundation
import UIKit

extension UIViewController {
    class var storyboardID: String {
        return "\(self)"
    }
    static func instantiate(fromAppStoryboard: AppStoryboard) -> Self {
        return fromAppStoryboard.viewController(viewControllerClass: self)
    }

    func showActionSheet(title: String, message: String, style: UIAlertController.Style, actions: [UIAlertAction?]) {
        let actionSheetController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: style)
        for action in actions {
            if let action = action {
                actionSheetController.addAction(action)
            }
        }
        self.present(actionSheetController, animated: true, completion: nil)
    }
    func actionMessageOK(_ completion: (() -> Void)? = nil) -> UIAlertAction {
        return UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default) { _ in
            completion?()
        }
    }
}
