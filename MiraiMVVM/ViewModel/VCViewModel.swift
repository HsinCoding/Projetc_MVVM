//
//  VCViewModel.swift
//  MiraiMVVM
//
//  Created by ＵＳＥＲ on 2019/11/27.
//  Copyright © 2019 hsin_project. All rights reserved.
//

import UIKit

class VCViewModel: NSObject, APIManagerDelegate {
   
    
    var onRequestEnd: (() -> Void)?
    public var listCellViewModels: [ListCellViewModel] = []
    var manager:APIManager?
    var index: Int = 0
    
    //Methods
    func fetchAllUser(since: String) {
        APIManager.shared.fetchAllUser(since: since)
        APIManager.shared.delegate = self
    }
    
    //Delegate
    func fetchAllUserSuccess(_presenter: APIManager, didfetch users: [ListCellViewModel]) {
      
        if listCellViewModels.count == 0 {
            listCellViewModels = users
            if listCellViewModels.count < 100 {
                index += 1
                self.fetchAllUser(since:String(index))
            }
        } else {
            
            for item in users {
                listCellViewModels.append(item)
                if listCellViewModels.count == 100 {
                    onRequestEnd?()
                    return
                }
            }
          
            if listCellViewModels.count < 100 {
                index += 1
                self.fetchAllUser(since:String(index))
            }
        }
    }
    
}
