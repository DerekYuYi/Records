//
//  ArticleFeedViewController.swift
//  IntegrateSiriShortcuts
//
//  Created by DerekYuYi on 2019/1/30.
//  Copyright © 2019 Wenlemon. All rights reserved.
//

import UIKit
import Intents
import ArticleKit
import CoreSpotlight
import MobileCoreServices

// NOTE: Use `Layouts.swift` to manage life cycle and part of UI.
class ArticleFeedViewController: UIViewController {
    
    let tableView = UITableView(frame: .zero, style: .plain)
    let cellIdentifier = "kArticleCellReuse"
    
    var articles: [Article] = []
    
    @objc func newArticleWastapped() {
        let vc = NewArticleViewController()
        
        // --------------------------------------------------- //
        // Create and donate an activity-based Shortcut
        let activity = Article.newArticleShortcut(with: UIImage(named: "notePad.jpg"))
        vc.userActivity = activity // 继承 Responder 的类, 拥有这个属性
        
        activity.becomeCurrent() // register activity 
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    // MARK: - Initialization
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ArticleTableViewCell.classForCoder(), forCellReuseIdentifier: cellIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension ArticleFeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = EditDraftViewController(article: articles[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func remove(article: Article, at indexPath: IndexPath) {
        
    }
}


