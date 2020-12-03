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
    
    @IBOutlet weak var watchersWidth: NSLayoutConstraint!
    @IBOutlet weak var followersWidth: NSLayoutConstraint!
    @IBOutlet weak var forksWidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    func configure(usingModel repoModel: RepositoryItemViewModel) {
        configAvatar(imageView: avatarImageView, url: repoModel.avatarUrl)
        titleLabel.text = repoModel.title
        descriptionLabel.text = repoModel.description
        followersLabel.translatesAutoresizingMaskIntoConstraints = false
        watchersLabel.translatesAutoresizingMaskIntoConstraints = false
        forksLabel.translatesAutoresizingMaskIntoConstraints = false
        
        if let followers = repoModel.followers {
            followersLabel.text = followers
            showView(hide: false, view: followersLabel)
            followersWidth.constant = 30.0
        } else {
            followersWidth.constant = 0.0
            showView(hide: true, view: followersLabel)
        }
        if let watchers = repoModel.watchers {
            watchersLabel.text = watchers
            showView(hide: false, view: watchersLabel)
            watchersWidth.constant = 30.0
        } else {
            watchersWidth.constant = 0.0
            showView(hide: true, view: watchersLabel)
        }
        if let forks = repoModel.forks {
            forksLabel.text = forks
            showView(hide: false, view: followersLabel)
            forksWidth.constant = 30.0
        } else {
            forksWidth.constant = 0.0
            showView(hide: true, view: followersLabel)
        }
        self.layoutIfNeeded()
    }
    func configAvatar(imageView: UIImageView, url: String) {
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        imageView.imageFromServerURL(url, placeHolder: UIImage(named: "user-placeholder"))
    }
    func showView(hide: Bool, view: UIView) {
        view.isHidden = hide
    }
}
