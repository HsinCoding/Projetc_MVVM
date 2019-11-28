//
//  VCListCell.swift
//  MiraiMVVM
//
//  Created by ＵＳＥＲ on 2019/11/28.
//  Copyright © 2019 hsin_project. All rights reserved.
//

import UIKit

class VCListCell: UITableViewCell {

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var adminView: UIView!
    @IBOutlet weak var siteAdminLabel: UILabel!
    private var viewModel: ListCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func prepareForReuse() {
           super.prepareForReuse()
           avatarImage.image = nil
           self.viewModel?.onImageDownloaded = nil
    }

    func setup(viewModel: ListCellViewModel) {
        self.viewModel = viewModel
        self.loginLabel.text = viewModel.login
        if viewModel.siteAdmin {
            self.siteAdminLabel.text = "Staff"
            self.adminView.isHidden = false
        } else {
            self.adminView.isHidden = true
        }
        self.viewModel?.onImageDownloaded = {[weak self] image in
            DispatchQueue.main.async {
                self?.avatarImage.image = image
            }
        }
        self.viewModel?.getImage()
    }
    
}
