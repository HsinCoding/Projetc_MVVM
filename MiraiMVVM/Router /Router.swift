//
//  Router.swift
//  MiraiMVVM
//
//  Created by ＵＳＥＲ on 2019/12/2.
//  Copyright © 2019 hsin_project. All rights reserved.
//

import UIKit

class Router: NSObject {

    static let shared = Router()
    
    func showDetailsVC(vc:UIViewController, viewModel:VCViewModel,indexPathRow:Int){
        let detailsVC = DetailsViewController()
        let listCellViewModel = viewModel.listCellViewModels[indexPathRow]
        detailsVC.username = listCellViewModel.login
        vc.present(detailsVC, animated: true, completion: nil)
    }
}
