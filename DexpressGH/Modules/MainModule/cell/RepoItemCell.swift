//
//  RepoItemCell.swift
//  DexpressGH
//
//  Created by Tracer on 28/11/20.
//  Copyright © 2020 Tracer. All rights reserved.
//

import UIKit

class RepoItemCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var watchersLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(usingModel repoModel: Repository) -> Void {
        
        //TODO: ADD a download method for url avatar image
        self.titleLabel.text = repoModel.name
        self.descriptionLabel.text = repoModel.itemDescription
        self.forksLabel.text = Double(repoModel.forks ?? 0).unitFormatted()
        self.watchersLabel.text = Double(repoModel.watchersCount ?? 0).unitFormatted()
        self.followersLabel.text = Double(repoModel.stargazersCount ?? 0).unitFormatted()
        
    }
}
