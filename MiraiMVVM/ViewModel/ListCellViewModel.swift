//
//  ListCellViewModel.swift
//  MiraiMVVM
//
//  Created by ＵＳＥＲ on 2019/11/27.
//  Copyright © 2019 hsin_project. All rights reserved.
//

import UIKit

enum TypeEnum: String, Codable {
    case organization = "Organization"
    case user = "User"
}

class ListCellViewModel: NSObject {
    
    private let downloadImageQueue = OperationQueue()
    var onImageDownloaded: ((UIImage?) -> Void)?
    
    let login: String
    let id: Int
    let nodeID: String
    let avatarURL: String
    let gravatarID: String
    let url, htmlURL, followersURL: String
    let followingURL, gistsURL, starredURL: String
    let subscriptionsURL, organizationsURL, reposURL: String
    let eventsURL: String
    let receivedEventsURL: String
    let type:String
    let siteAdmin: Bool
    
    init(login: String, id: Int, nodeID: String, avatarURL: String, gravatarID: String, url: String, htmlURL: String, followersURL: String, followingURL: String, gistsURL: String, starredURL: String, subscriptionsURL: String, organizationsURL: String, reposURL: String, eventsURL: String,receivedEventsURL: String, type:String, siteAdmin: Bool) {
        self.login = login
        self.id = id
        self.nodeID = nodeID
        self.avatarURL = avatarURL
        self.gravatarID = gravatarID
        self.url = url
        self.htmlURL = htmlURL
        self.followersURL = followersURL
        self.followingURL = followingURL
        self.gistsURL = gistsURL
        self.starredURL = starredURL
        self.subscriptionsURL = subscriptionsURL
        self.organizationsURL = organizationsURL
        self.reposURL = reposURL
        self.eventsURL = eventsURL
        self.receivedEventsURL = receivedEventsURL
        self.type = type
        self.siteAdmin = siteAdmin
    }
    
       func getImage() {
        
        guard let url = URL(string: avatarURL) else { return }
        downloadImageQueue.addOperation { [weak self] in
           do {
               let data = try Data(contentsOf: url)
               let image = UIImage(data: data)
               guard let imageDownloaded = self?.onImageDownloaded else { return }
               imageDownloaded(image)
            
           } catch let error {
               print(error)
           }
        }
    }
    
}
