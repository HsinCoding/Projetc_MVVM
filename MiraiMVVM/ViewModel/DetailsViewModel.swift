//
//  DetailsViewModel.swift
//  MiraiMVVM
//
//  Created by ＵＳＥＲ on 2019/11/28.
//  Copyright © 2019 hsin_project. All rights reserved.
//

import UIKit

class DetailsViewModel: NSObject  {
    
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
    let type: String
    let siteAdmin: Bool
    let name: String
    let company: String
    let blog: String
    let location: String
    let email, hireable, bio: String
    let publicRepos, publicGists, followers, following: Int
    let createdAt, updatedAt: String

    init(login: String, id: Int, nodeID: String, avatarURL: String, gravatarID: String, url: String, htmlURL: String, followersURL: String, followingURL: String, gistsURL: String, starredURL: String, subscriptionsURL: String, organizationsURL: String, reposURL: String, eventsURL: String, receivedEventsURL: String, type: String, siteAdmin: Bool, name: String, company: String, blog: String, location: String, email: String, hireable: String, bio: String, publicRepos: Int, publicGists: Int, followers: Int, following: Int, createdAt: String, updatedAt: String) {
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
        self.name = name
        self.company = company
        self.blog = blog
        self.location = location
        self.email = email
        self.hireable = hireable
        self.bio = bio
        self.publicRepos = publicRepos
        self.publicGists = publicGists
        self.followers = followers
        self.following = following
        self.createdAt = createdAt
        self.updatedAt = updatedAt
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
            print(error.localizedDescription)
           }
        }
    }
}
