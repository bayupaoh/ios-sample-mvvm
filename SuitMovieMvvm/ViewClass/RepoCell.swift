//
//  RepoCell.swift
//  SuitMovieMvvm
//
//  Created by Rifat Firdaus on 10/3/18.
//  Copyright © 2018 Rifat Firdaus. All rights reserved.
//

import UIKit

class RepoCell: UITableViewCell {

    @IBOutlet var labelName: UILabel!
    @IBOutlet var labelUrl: UILabel!
    @IBOutlet var labelDate: UILabel!
    
    var repo: Repo? {
        didSet {
            if let repo = repo {
                labelName.text = repo.name ?? " "
                labelUrl.text = repo.htmlUrl ?? " "
                labelDate.text = repo.updatedAt != nil ? (repo.updatedAt?.toColloquialString() ?? " ") : " "
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
