// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let gMGithubUserModel = try? newJSONDecoder().decode(GMGithubUserModel.self, from: jsonData)

//
// To read values from URLs:
//
//   let task = URLSession.shared.gMGithubUserModelElementTask(with: url) { gMGithubUserModelElement, response, error in
//     if let gMGithubUserModelElement = gMGithubUserModelElement {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - GMGithubUserModelElement
struct GMGithubUserModel: Codable, Equatable, Hashable {
    let login: String
    let id: Int
    let nodeID: String
    let avatarURL: String?
    let gravatarID: String
    let url, htmlURL, followersURL: String
    let followingURL, gistsURL, starredURL: String
    let subscriptionsURL, organizationsURL, reposURL: String


    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
    }
    
    static func == (lhs: GMGithubUserModel, rhs: GMGithubUserModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .iso8601

    return encoder
}

// MARK: - URLSession response handlers

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping ([T]?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode([T].self, from: data), response, nil)
        }
    }

    func gMGithubUserModelTask(with url: URL, completionHandler: @escaping ([GMGithubUserModel]?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
