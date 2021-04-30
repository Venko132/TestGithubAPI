//
//  Constants.swift
//  GithubMessanger
//
//  Created by Dream Store on 29.04.2021.
//

import Foundation

struct Constants {
    struct API {
        static let baseURL: String = "https://api.github.com/"
        static let pageOffset: Int = 30
        static let defaultUserAvatar: String = "https://api.drupal.org/sites/default/files/default-avatar.png"
    }
    
    struct Notification {
        static let updateUI: String = "updateUI"
    }
}
