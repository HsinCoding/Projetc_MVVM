//
//  DetailsViewController.swift
//  MiraiMVVM
//
//  Created by ＵＳＥＲ on 2019/11/28.
//  Copyright © 2019 hsin_project. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    let viewModel = DetailsVCViewModel()
    var username: String = ""
    
    @IBOutlet weak var avatarImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var siteAdminLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var blogLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
        viewModel.fetchSingleUser(username: self.username)
       
    }
    
    // MARK: - Bind ViewModel
    func bindViewModel() {
        self.viewModel.onRequestEnd = { [weak self] in
            DispatchQueue.main.async {
                self?.setData(model: (self?.viewModel.detailsViewModel)!)
            }
        }
    }
   
    func setData(model:DetailsViewModel) {
        self.nameLabel.text = model.name
        self.locationLabel.text = model.location
        self.blogLabel.text = model.blog
        
        model.onImageDownloaded = {[weak self] image in
            DispatchQueue.main.async {
                self?.avatarImg.image = image
            }
        }
        model.getImage()
    }

}
