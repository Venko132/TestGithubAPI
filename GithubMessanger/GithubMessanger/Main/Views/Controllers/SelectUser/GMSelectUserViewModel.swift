//
//  GMSelectUserViewModel.swift
//  GithubMessanger
//
//  Created by Dream Store on 29.04.2021.
//

import Foundation

class GMSelectUserViewModel {
    
    //MARK: Properties
    private(set) var listUsers: [GMGithubUserModel] = [GMGithubUserModel]()
    var selectedUsers = Set<GMGithubUserModel>()
    
    var resultBlock: ((Result<Bool,GMError>) -> Void)?
    
    //MARK: LifeCycle
    init() {
    }
    
    //MARK: Methods
    
    func lastUserId() -> Int? {
        return self.listUsers.last?.id
    }
    
    func removeSelectedUser(_ user: GMGithubUserModel) {
        self.selectedUsers.remove(user)
    }
    
    func atLeastOneUserIsSelected() -> Bool {
        return self.selectedUsers.count > 0
    }
    
    func deselectAllUsers() {
        self.selectedUsers.removeAll()
    }
    
    func cleanData() {
        deselectAllUsers()
        self.listUsers.removeAll()
    }
    
    func fetchUsers() {
        let userId = lastUserId()
        GMAPIHandler.sharedInstance.fetchUsers(lastUserId: userId, perPage: Constants.API.pageOffset, callback: { [weak self](result) in
            guard let weakSelf = self else {
                return
            }
            
            switch result {
            case .success(let users): do {
                if userId == nil {
                    weakSelf.listUsers.removeAll()
                }
                weakSelf.listUsers.append(contentsOf: users)
                weakSelf.resultBlock?(.success(true))
            }
            case .failure(let error):
                weakSelf.resultBlock?(.failure(error))
            }
        })
    }
}
