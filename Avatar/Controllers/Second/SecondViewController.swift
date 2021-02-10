//
//  SecondViewController.swift
//  Avatar
//
//  Created by MohammadReza on 2/11/21.
//

import UIKit

class SecondViewController: BaseViewController {

//MARK:- Views
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!

    //init var
    var viewModel: AvatarViewModel!
    var avatarDetails: Details!

//MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initialize()
        getDetails()
    }

//MARK:- Other methods
    fileprivate func initialize() {
        viewModel = AvatarViewModel()
    }

    fileprivate func fillViews(details: Details) {
        imageView.sd_setImage(with: URL(string: details.poster), completed: nil)
        textView.text = "\(details.description)"
    }

//MARK:- Actions
    @IBAction func didTapOnBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

//MARK:- Api call
    fileprivate func getDetails() {
        showHud(view: self.view)
        viewModel.getAvatarDetails { (details, error) in
            if error == nil {
                self.hideUud()
                if let details = details {
                    self.fillViews(details: details)
                } else {
                    self.showActionSheet(title: "error".getString(), message: "emptyData".getString(), style: .alert, actions: [self.actionMessageOK()])
                }
            } else {
                self.hideUud()
                self.showActionSheet(title: error!.title, message: error!.message, style: .alert, actions: [self.actionMessageOK()])
            }
        }
    }

}
