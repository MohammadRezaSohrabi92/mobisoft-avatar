//
//  ViewController.swift
//  Avatar
//
//  Created by MohammadReza on 2/11/21.
//

import UIKit
import SDWebImage

class ViewController: BaseViewController {

//MARK:- Views
    @IBOutlet weak var mainTable: UITableView!

    //init var
    let avatarTableIdentifier = "AvatarTableIdentifier"
    var avatarList: AvatarList!
    var viewModel: AvatarViewModel!

//MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        initialize()
        getAvatarList()
    }

//MARK:- Other methods
    fileprivate func initialize() {
        viewModel = AvatarViewModel()
    }

    fileprivate func fillTable(list: AvatarList) {
        self.avatarList = list
        mainTable.reloadData()
    }

//MARK:- Api call
    func getAvatarList() {
        self.showHud(view: self.view)
        viewModel.getAvatarList { (avatarList, error) in
            if error == nil {
                self.hideUud()
                if let list = avatarList {
                    self.fillTable(list: list)
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

//MARK: - extensions
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let list = avatarList, !list.search.isEmpty {
            return list.search.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: avatarTableIdentifier, for: indexPath)
        cell.textLabel?.text = avatarList.search[indexPath.row].title
        if !avatarList.search[indexPath.row].poster.contains("N/A") {
            cell.imageView?.sd_setImage(with: URL(string: avatarList.search[indexPath.row].poster), completed: nil)
        } else {
            cell.imageView?.image = .checkmark
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(AppStoryboard.Second.viewController(viewControllerClass: SecondViewController.self), animated: true)
    }
    
}
