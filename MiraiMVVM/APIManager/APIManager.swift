//
//  APIManager.swift
//  MiraiMVVM
//
//  Created by ＵＳＥＲ on 2019/11/27.
//  Copyright © 2019 hsin_project. All rights reserved.
//

import UIKit

@objc protocol APIManagerDelegate: class {
    @objc optional func fetchAllUserSuccess(_presenter: APIManager, didfetch users:[ListCellViewModel])
    @objc optional func fetchSingleUserSuccess(_presenter: APIManager, didfetch user:DetailsViewModel)
}

class APIManager: NSObject {
    
    weak var delegate: APIManagerDelegate?
    static let shared = APIManager()

    func fetchAllUsers(since: String) {
        let urlString = "https://api.github.com/users?since=\(since)"
        let url = URL(string:urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        var dataArray:[ListCellViewModel] = []
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription as Any)
            } else {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    guard let array = json as? Array<Dictionary<String, Any>> else { return }
                    for item in array {
                        guard let login = item["login"] as? String else { return  }
                        guard let id = item["id"] as? Int else { return }
                        guard let nodeID = item["node_id"] as? String else { return  }
                        guard let avatarURL = item["avatar_url"] as? String else { return  }
                        guard let gravatarID = item["gravatar_id"] as? String else { return  }
                        guard let url = item["url"] as? String else { return  }
                        guard let htmlURL = item["html_url"] as? String else { return  }
                        guard let followersURL = item["followers_url"] as? String else { return  }
                        guard let followingURL = item["following_url"] as? String else { return  }
                        guard let gistsURL = item["gists_url"] as? String else { return  }
                        guard let starredURL = item["starred_url"] as? String else { return  }
                        guard let subscriptionsURL = item["subscriptions_url"] as? String else { return  }
                        guard let organizationsURL = item["organizations_url"] as? String else { return  }
                        guard let reposURL = item["repos_url"] as? String else { return  }
                        guard let eventsURL = item["events_url"] as? String else { return  }
                        guard let receivedEventsURL = item["received_events_url"] as? String else { return  }
                        guard let type = item["type"] as? String else { return  }
                        guard let siteAdmin = item["site_admin"] as? Bool else { return  }
                                               
                        
                        let model = ListCellViewModel(login: login, id: id, nodeID: nodeID, avatarURL: avatarURL, gravatarID: gravatarID, url: url, htmlURL: htmlURL, followersURL: followersURL, followingURL: followingURL, gistsURL: gistsURL, starredURL: starredURL, subscriptionsURL: subscriptionsURL, organizationsURL: organizationsURL, reposURL: reposURL, eventsURL: eventsURL, receivedEventsURL: receivedEventsURL, type: type, siteAdmin: siteAdmin)
                        
                        dataArray.append(model)
                    }
                    self.delegate?.fetchAllUserSuccess!(_presenter: self, didfetch: dataArray)
                    
                } catch  {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
    
    func fetchSingleUser(username: String) {
        let urlString = "https://api.github.com/users/\(username)"
        let url = URL(string:urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription as Any)
            } else {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    guard let data = json as? Dictionary<String, Any> else { return }
                   
                    let login = data["login"] as? String ?? "None"
                    guard let id = data["id"] as? Int else { return }
                    let nodeID = data["node_id"] as? String ?? "None"
                    let avatarURL = data["avatar_url"] as? String ?? "None"
                    let gravatarID = data["gravatar_id"] as? String ?? "None"
                    let url = data["url"] as? String ?? "None"
                    let htmlURL = data["html_url"] as? String ?? "None"
                    let followersURL = data["followers_url"] as? String ?? "None"
                    let followingURL = data["following_url"] as? String ?? "None"
                    let gistsURL = data["gists_url"] as? String ?? "None"
                    let starredURL = data["starred_url"] as? String ?? "None"
                    let subscriptionsURL = data["subscriptions_url"] as? String ?? "None"
                    let organizationsURL = data["organizations_url"] as? String ?? "None"
                    let reposURL = data["repos_url"] as? String ?? "None"
                    let eventsURL = data["events_url"] as? String ?? "None"
                    let receivedEventsURL = data["received_events_url"] as? String ?? "None"
                    let type = data["type"] as? String ?? "None"
                    guard let siteAdmin = data["site_admin"] as? Bool else { return  }
                    let name = data["name"] as? String ?? "None"
                    let company = data["company"] as? String ?? "None"
                    let blog = data["blog"] as? String ?? "None"
                    let location = data["location"] as? String ?? "None"
                    let email = data["email"] as? String ?? "None"
                    let hireable = data["hireable"] as? String ?? "None"
                    let bio = data["bio"] as? String ?? "None"
                    let public_repos = data["public_repos"] as? Int ?? 0
                    let public_gists = data["public_gists"] as? Int ?? 0
                    let followers = data["followers"] as? Int ?? 0
                    let following = data["following"] as? Int ?? 0
                    let created_at = data["created_at"] as? String ?? "None"
                    let updated_at = data["updated_at"] as? String ?? "None"
                    
                    let model = DetailsViewModel(login: login, id: id, nodeID: nodeID, avatarURL: avatarURL, gravatarID: gravatarID, url: url, htmlURL: htmlURL, followersURL: followersURL, followingURL: followingURL, gistsURL: gistsURL, starredURL: starredURL, subscriptionsURL: subscriptionsURL, organizationsURL: organizationsURL, reposURL: reposURL, eventsURL: eventsURL, receivedEventsURL: receivedEventsURL, type: type, siteAdmin: siteAdmin, name: name, company: company, blog: blog, location: location, email: email, hireable: hireable, bio: bio, publicRepos: public_repos, publicGists: public_gists, followers: followers, following: following, createdAt: created_at, updatedAt: updated_at)
                    
                    self.delegate?.fetchSingleUserSuccess?(_presenter: self, didfetch: model)
                } catch  {
                    print(error.localizedDescription)
                }
            }
        }.resume()

    }
}
