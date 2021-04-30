//
//  GMSelectUserController.swift
//  GithubMessanger
//
//  Created by Dream Store on 29.04.2021.
//

import UIKit

class GMSelectUserController: GMBaseController {

    //MARK: IBOutlets
    @IBOutlet private weak var tblView: UITableView!
    @IBOutlet private weak var vwSelectedUsers: GMSelectedUsersView!
    
    //MARK: Properties
    let viewModel = GMSelectUserViewModel()
    lazy var navCoordinator: GMSelectUserCoordinator = {
        return GMSelectUserCoordinator(navController: self.navigationController)
    }()
    private lazy var tablePresenter: GMSelectUserTablePresenter = {
        return GMSelectUserTablePresenter(vm: self.viewModel, table: self.tblView, delegate: self)
    }()
    private lazy var btnNext: UIBarButtonItem = {
        let btn = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(openNextScreen))
        btn.isEnabled = false
        return btn
    }()
    
    //MARK: LifeCyce
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tablePresenter.reloadTable()
    }
    
    //MARK: Methods
    override func prepareParameters() {
        
        self.navigationItem.title = "Selected Users"
        self.navigationItem.rightBarButtonItem = self.btnNext
        self.navigationController?.navigationBar.tintColor = .white
        
        self.vwSelectedUsers.configure(vm: self.viewModel)
        
        configureResultBlock()
        fetchData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(upateUI), name: Constants.Notification.updateUI.notificationName(), object: nil)
    }
    
    private func configureResultBlock() {
        self.viewModel.resultBlock = { [weak self] (result) in
            guard let weakSelf = self else { return }
            weakSelf.endProgress()
            
            switch result {
            case .failure(let error):
                GMHelperHandler.showAlert(message: error.localizedDescription)
            case .success(let result):
                guard result else { return }
                
                weakSelf.tablePresenter.reloadTable()
            }
        }
    }
    
    private func fetchData() {
        startProgress()
        self.viewModel.fetchUsers()
    }
    
    @objc private func upateUI(_ notification: Notification) {
        let update = {
            self.tablePresenter.reloadTable()
            self.btnNext.isEnabled = self.viewModel.atLeastOneUserIsSelected()
        }
        
        guard let needReloadAllData = notification.object as! Bool?, needReloadAllData else {
            update()
            return
        }
        
        self.viewModel.cleanData()
        update()
        fetchData()
    }
    
    @objc private func openNextScreen() {
        self.navCoordinator.routeToComposeMessage(vm: self.viewModel)
    }
}

//MARK:- GMProtocolSelectCell & GMProtocolFetchContent
extension GMSelectUserController: GMProtocolActionInCell, GMProtocolFetchContent {
    
    func toLoadNewData() {
        fetchData()
    }
}
