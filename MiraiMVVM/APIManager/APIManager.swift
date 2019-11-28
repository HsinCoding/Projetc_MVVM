//
//  APIManager.swift
//  MiraiMVVM
//
//  Created by ＵＳＥＲ on 2019/11/27.
//  Copyright © 2019 hsin_project. All rights reserved.
//

import UIKit

protocol APIManagerDelegate: class {
    func fetchAllUserSuccess(_presenter: APIManager, didfetch users:[ListCellViewModel])
}


class APIManager: NSObject {
    
    weak var delegate: APIManagerDelegate?
    static let shared = APIManager()
 
    func fetchAllUser(since: String) {
        let urlString = "https://api.github.com/users?since=\(since)"
        let url = URL(string:urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        var dataArray:[ListCellViewModel] = []
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription)
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
                    self.delegate?.fetchAllUserSuccess(_presenter: self, didfetch: dataArray)
                    
                } catch  {
                    print(error.localizedDescription)
                }
            }
            
            
            
        }.resume()
       
        
    }
    
    
}
