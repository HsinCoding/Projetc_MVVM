//
//  DetailsVCViewModel.swift
//  MiraiMVVM
//
//  Created by ＵＳＥＲ on 2019/11/28.
//  Copyright © 2019 hsin_project. All rights reserved.
//

import UIKit

class DetailsVCViewModel: NSObject, APIManagerDelegate {
    
    var onRequestEnd: (() -> Void)?
    var manager:APIManager?
    public var detailsViewModel: DetailsViewModel?
    
    //Methods
    func fetchSingleUser(username: String)  {
        APIManager.shared.fetchSingleUser(username: username)
        APIManager.shared.delegate = self
    }

        
    //Delegate
    func fetchSingleUserSuccess(_presenter: APIManager, didfetch user: DetailsViewModel) {
        
        detailsViewModel = user
        onRequestEnd!()
        
    }
    
}
