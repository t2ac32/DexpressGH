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
    
    func configure(usingModel repoModel: RepositoryItemViewModel) -> Void {
        self.contentView.layer.cornerRadius = 8
        self.contentView.layer.masksToBounds = true
        
        configAvatar(imageView: avatarImageView, url: repoModel.avatarUrl)
        
        //TODO: ADD a download method for url avatar image
        self.titleLabel.text = repoModel.title
        self.descriptionLabel.text = repoModel.description
        self.forksLabel.text = repoModel.forks
        self.watchersLabel.text = repoModel.watchers
        self.followersLabel.text = repoModel.followers
        
    }
    
    func configAvatar(imageView: UIImageView, url:String) {
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        imageView.imageFromServerURL(url, placeHolder: UIImage(named: "user-placeholder"))
    }
    
    
}
