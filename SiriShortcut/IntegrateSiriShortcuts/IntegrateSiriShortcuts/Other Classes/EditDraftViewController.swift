//
//  EditDraftViewController.swift
//  IntegrateSiriShortcuts
//
//  Created by DerekYuYi on 2019/2/15.
//  Copyright © 2019 Wenlemon. All rights reserved.
//

import UIKit
import ArticleKit

class EditDraftViewController: UIViewController {
    let titleTextField = UITextField()
    let contentsTextView = UITextView()

    var article: Article

    init(article: Article) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func saveWasTapped() {
        if let title = titleTextField.text, let content = contentsTextView.text {
            article = ArticleManager.update(article: article, title: title, content: content)

            navigationController?.popViewController(animated: true)
        }
    }

    @objc func publishWasTapped() {
        if let title = titleTextField.text, let content = contentsTextView.text {
            article = ArticleManager.update(article: article, title: title, content: content)
            ArticleManager.publish(article)
            navigationController?.popViewController(animated: true)
        } else {
            // Show alert

        }
    }
}
