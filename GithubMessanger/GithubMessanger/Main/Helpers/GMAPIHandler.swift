//
//  GMAPIHandler.swift
//  GithubMessanger
//
//  Created by Dream Store on 29.04.2021.
//

import Foundation

class GMAPIHandler {
    let serialQueue = DispatchQueue(label: "serial.queue")
    
    //MARK: Instance
    static let sharedInstance = GMAPIHandler()
    private init() {
    }
    
    //MARK: Methods
    func fetchUsers(lastUserId: Int? = nil, perPage: Int, callback: @escaping (Result<[GMGithubUserModel], GMError>) -> Void) {
        var path = Constants.API.baseURL + "users?per_page=\(perPage)"
        if let lastUserId = lastUserId {
            path += "&since=\(lastUserId)"
        }
        
        guard let url = URL.init(string: path) else {
            callback(.failure(GMError.init(localizedDescription: "Invalid url.")))
            return
        }
        
        let semaphore = DispatchSemaphore(value: 0)
        
        serialQueue.async {
            let task = URLSession.shared.gMGithubUserModelTask(with: url)
            { (list, response, error) in
                semaphore.signal()
                DispatchQueue.main.async {
                    guard let error = error else {
                        callback(.success(list ?? []))
                        return
                    }
                    
                    callback(.failure(GMError.init(localizedDescription: error.localizedDescription)))
                }
            }
            task.resume()
        }
    }
}
