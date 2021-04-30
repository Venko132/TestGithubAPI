//
//  GMSelectedUserItemVIewModel.swift
//  GithubMessanger
//
//  Created by Dream Store on 30.04.2021.
//

import Foundation

class GMSelectedUserItemViewModel {
    //MARK: Properties
    private var model: GMGithubUserModel!
    
    //MARK: LifeCycle
    init(data model: GMGithubUserModel) {
        self.model = model
    }
    
    //MARK: Methods
    func username() -> String {
        return self.model.login.capitalized
    }
    
    func avatarUrl() -> URL? {
        guard let url = self.model.avatarURL else { return URL.init(string: Constants.API.defaultUserAvatar) }
        return URL.init(string: url)
    }
}
