//
//  GMSelectUserTablePresenter.swift
//  GithubMessanger
//
//  Created by Dream Store on 29.04.2021.
//

import Foundation
import UIKit

class GMSelectUserTablePresenter: NSObject {
    static let cellHeight: CGFloat = 118.0
    
    //MARK: Properties
    private(set) var viewModel: GMSelectUserViewModel
    private(set) var tableView: UITableView
    weak var delegate: (GMProtocolActionInCell & GMProtocolFetchContent)? = nil
    
    //MARK: Init
    init(vm viewModel: GMSelectUserViewModel, table: UITableView, delegate: (GMProtocolActionInCell & GMProtocolFetchContent)? = nil) {
        self.viewModel = viewModel
        self.tableView = table
        self.delegate = delegate
        
        super.init()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        
        registerNib(GMGithubUserCell.kIdentifier)
    }
    
    //MARK: Methods
    func reloadTable() {
        self.tableView.reloadData()
    }
    
    private func registerNib(_ identifier: String) {
        let nib = UINib.init(nibName: identifier, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: identifier)
    }
}

//MARK:- UITableViewDataSource, UITableViewDelegate
extension GMSelectUserTablePresenter: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return GMSelectUserTablePresenter.cellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let count = self.viewModel.listUsers.count
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        cell = configureCell(at: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    
    private func configureCell(at indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: GMGithubUserCell.kIdentifier) as! GMGithubUserCell
        
        let model = self.viewModel.listUsers[indexPath.row]
        cell.configure(GMGithubUserCellViewModel(data: model))
        cell.delegateActionInCell = self
        cell.btnCheck.isSelected = self.viewModel.selectedUsers.contains(model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let offset = self.viewModel.listUsers.count - 5
        guard indexPath.row == offset else {
            return
        }
        
        self.delegate?.toLoadNewData()
    }
}

//MARK:- GMProtocolActionInCell
extension GMSelectUserTablePresenter: GMProtocolActionInCell {
    func actionUserPressSender(_ sender: AnyObject) {
        let buttonPosition: CGPoint = sender.convert(CGPoint.zero, to: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: buttonPosition)
        
        guard let _indexPath = indexPath, let button = sender as? UIButton else { return }
        let message = self.viewModel.listUsers[_indexPath.row]
        
        if !button.isSelected {
            self.viewModel.selectedUsers.insert(message)
        } else {
            self.viewModel.selectedUsers.remove(message)
        }
        button.isSelected = !button.isSelected
        
        //self.tableView.reloadData()
        
        NotificationCenter.default.post(name: Constants.Notification.updateUI.notificationName(), object: nil)
    }
}
    
