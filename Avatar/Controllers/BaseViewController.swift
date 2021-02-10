//
//  BaseViewController.swift
//  Avatar
//
//  Created by MohammadReza on 2/11/21.
//

import UIKit
import JGProgressHUD

class BaseViewController: UIViewController {

    let hud = JGProgressHUD()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        hud.textLabel.text = "Loading"
    }
    
    func showHud(view: UIView) {
        hud.show(in: self.view)
    }

    func hideUud() {
        hud.dismiss(afterDelay: 1.0)
    }
}

extension BaseViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
