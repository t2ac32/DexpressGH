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
    func configure(usingModel repoModel: RepositoryItemViewModel) {
        configAvatar(imageView: avatarImageView, url: repoModel.avatarUrl)
        titleLabel.text = repoModel.title
        descriptionLabel.text = repoModel.description
        var constraints: [NSLayoutConstraint] = []
        if let followers = repoModel.followers {
            followersLabel.text = followers
            showView(hide: false, view: followersLabel)
            constraints.append(followersLabel.widthAnchor.constraint(equalToConstant: 27.0))
        } else {
            constraints.append(followersLabel.widthAnchor.constraint(equalToConstant: 0.0))
            showView(hide: true, view: followersLabel)
        }
        if let watchers = repoModel.watchers {
            watchersLabel.text = watchers
            showView(hide: false, view: watchersLabel)
            constraints.append(watchersLabel.widthAnchor.constraint(equalToConstant: 27.0))
        } else {
            constraints.append(watchersLabel.widthAnchor.constraint(equalToConstant: 0.0))
            showView(hide: true, view: watchersLabel)
        }
        if let forks = repoModel.forks {
            forksLabel.text = forks
            showView(hide: false, view: followersLabel)
            constraints.append(forksLabel.widthAnchor.constraint(equalToConstant: 27.0))
        } else {
            constraints.append(forksLabel.widthAnchor.constraint(equalToConstant: 0.0))
            showView(hide: true, view: followersLabel)
        }
        NSLayoutConstraint.activate(constraints)
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
