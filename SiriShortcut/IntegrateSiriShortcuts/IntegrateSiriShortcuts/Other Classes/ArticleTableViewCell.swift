//
//  ArticleTableViewCell.swift
//  IntegrateSiriShortcuts
//
//  Created by DerekYuYi on 2019/2/15.
//  Copyright © 2019 Wenlemon. All rights reserved.
//

import UIKit
import ArticleKit

class ArticleTableViewCell: UITableViewCell {
    
    let titleLabel = UILabel()
    var publishStatusLabel = UILabel()
    
    var article: Article {
        didSet {
            initializeTitleLabel()
            article.published ? showArticleWasPublished() : showArticleIsDraft()
            setNeedsLayout()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        article = Article(title: "placeholder", content: "placeholder", published: false)
        publishStatusLabel = ArticleTableViewCell.statusLabel(title: "")
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(titleLabel)
        addSubview(publishStatusLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.sizeToFit()
        titleLabel.bounds = CGRect(x: 0, y: 0, width: min(titleLabel.bounds.width, 150.0), height: titleLabel.bounds.height)
        titleLabel.center = CGPoint(x: titleLabel.bounds.width/2.0 + 16, y: bounds.height/2.0)
        
        publishStatusLabel.sizeToFit()
        publishStatusLabel.bounds = CGRect(x: 0, y: 0, width: publishStatusLabel.bounds.width + 30, height: publishStatusLabel.bounds.height + 8)
        publishStatusLabel.center = CGPoint(x: bounds.width - publishStatusLabel.bounds.width/2.0 - 16.0, y: bounds.height/2.0)
    }
    
    private func initializeTitleLabel() {
        titleLabel.text = article.title
        titleLabel.font = UIFont.systemFont(ofSize: 24.0)
    }
    
    class func statusLabel(title: String) -> UILabel {
        let label = UILabel()
        
        label.text = title
        label.layer.cornerRadius = 4.0
        label.layer.borderWidth = 1.0
        label.textAlignment = .center;
        return label
    }
    
    func showArticleWasPublished() {
        publishStatusLabel.text = "PUBLISHED"
        
        let green = UIColor(red: 0.0/255.0, green: 104.0/255.0, blue: 55.0/255.0, alpha: 1.0)
        
        publishStatusLabel.textColor = green
        publishStatusLabel.layer.borderColor = green.cgColor
    }
    
    func showArticleIsDraft() {
        publishStatusLabel.text = "DRAFT"
        
        let yellow = UIColor(red: 254.0/255.0, green: 223.0/255.0, blue: 0.0, alpha: 1.0)
        
        publishStatusLabel.textColor = yellow
        publishStatusLabel.layer.borderColor = yellow.cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
