//
//  NewArticleViewController.swift
//  IntegrateSiriShortcuts
//
//  Created by DerekYuYi on 2019/1/30.
//  Copyright © 2019 Wenlemon. All rights reserved.
//

import UIKit
import IntentsUI
import ArticleKit

class NewArticleViewController: UIViewController {
    let titleTextField = UITextField()
    let contentsTextView = UITextView()
    let addShortcutButton = UIButton()
    
    @objc func saveWasTapped() {
        if let title = titleTextField.text, let content = contentsTextView.text {
            let article = Article(title: title, content: content, published: false)
            ArticleManager.add(article: article)
            
            // Donate publish intent
            article.donatePublishIntent()
            
            navigationController?.popViewController(animated: true)
        }
    }

    // 添加一个 shortcuts 页面, 需要 import IntentsUI framework. 这里跟 在 设置中添加是一样的
    @objc func addNewArticleShortcutWasTapped() {
        // Open View Controller to Create New Shortcut
        let newArticleActivity = Article.newArticleShortcut(with: UIImage(named: "notePad.jpg"))
        let shortcut = INShortcut(userActivity: newArticleActivity)
        
        let vc = INUIAddVoiceShortcutViewController(shortcut: shortcut)
        vc.delegate = self
        
        present(vc, animated: true, completion: nil)
    }
}

extension NewArticleViewController: INUIAddVoiceShortcutViewControllerDelegate {
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
    
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        dismiss(animated: true, completion: nil)
    }
}
