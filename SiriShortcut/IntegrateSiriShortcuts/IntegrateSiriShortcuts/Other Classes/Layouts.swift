//
//  Layouts.swift
//  IntegrateSiriShortcuts
//
//  Created by DerekYuYi on 2019/2/15.
//  Copyright © 2019 Wenlemon. All rights reserved.
//

import UIKit
import ArticleKit
import Intents

extension ArticleFeedViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        articles = ArticleManager.allArticles()
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        navigationItem.title = "Articles"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New Article",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(newArticleWastapped))
        tableView.allowsMultipleSelectionDuringEditing = false
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
}


extension ArticleFeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ArticleTableViewCell
        cell.article = articles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let article = articles[indexPath.row]
            remove(article: article, at: indexPath)
            
            if articles.count == 0 {
                NSUserActivity.deleteSavedUserActivities(withPersistentIdentifiers: [NSUserActivityPersistentIdentifier(kNewArticleActivityType)]) {
                    debugPrint("Successfully deleted 'New Article' activity.")
                }
            }
        }
    }
}

extension NewArticleViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // Shortcuts Button
        addShortcutButton.setTitle("Add Shortcut to Siri", for: .normal)
        addShortcutButton.addTarget(self, action: #selector(addNewArticleShortcutWasTapped), for: .touchUpInside)
        addShortcutButton.setTitleColor(.blue, for: .normal)
        
        // Navbar
        navigationItem.title = "New Article"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save Draft",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(saveWasTapped))
        
        // Text Fields
        titleTextField.placeholder = "Title"
        titleTextField.delegate = self
        
        contentsTextView.layer.cornerRadius = 4.0
        contentsTextView.layer.borderColor = UIColor.black.cgColor
        contentsTextView.layer.borderWidth = 1.0
        contentsTextView.delegate = self
        
        view.addSubview(addShortcutButton)
        view.addSubview(titleTextField)
        view.addSubview(contentsTextView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let navbarHeight: CGFloat = 44.0
        var topPadding: CGFloat = 20.0
        var bottomPadding: CGFloat = 20.0
        let paddingBetween: CGFloat = 20.0
        
        if let topInset = UIApplication.shared.keyWindow?.safeAreaInsets.top {
            topPadding += topInset
        }
        if let bottomInset = UIApplication.shared.keyWindow?.safeAreaInsets.bottom {
            bottomPadding += bottomInset
        }
        
        addShortcutButton.bounds = CGRect(x: 0, y: 0, width: view.bounds.width, height: 44.0)
        addShortcutButton.center = CGPoint(x: view.bounds.width/2.0, y: titleTextField.bounds.height/2.0 + topPadding + navbarHeight)
        
        titleTextField.bounds = CGRect(x: 0, y: 0, width: view.bounds.width - 32.0, height: 44.0)
        titleTextField.center = CGPoint(x: titleTextField.bounds.width/2.0 + 16.0, y: titleTextField.bounds.height/2.0 + addShortcutButton.center.y + addShortcutButton.bounds.height/2.0)
        
        let contentsTextViewYOrigin = titleTextField.bounds.height + titleTextField.frame.origin.y + 20.0
        let height = view.bounds.height - (titleTextField.center.y + titleTextField.bounds.height/2.0) - paddingBetween - bottomPadding
        contentsTextView.frame = CGRect(x: 16.0, y: contentsTextViewYOrigin, width: view.bounds.width - 32.0, height: height)
    }
    
    override func updateUserActivityState(_ activity: NSUserActivity) {
        guard let title = titleTextField.text, let content = contentsTextView.text else {
            return
        }
        
        activity.addUserInfoEntries(from: ["title": title, "content": content])
        
        super.updateUserActivityState(activity) // UIResponder
    }
}

extension NewArticleViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        userActivity?.needsSave = true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        userActivity?.needsSave = true
        
        return true
    }
}

extension NewArticleViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        userActivity?.needsSave = true
    }
}

extension EditDraftViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // Navbar
        navigationItem.title = "Edit Draft"
        navigationItem.rightBarButtonItems = [UIBarButtonItem(title: "Publish",
                                                              style: .plain,
                                                              target: self,
                                                              action: #selector(EditDraftViewController.publishWasTapped)),
                                              UIBarButtonItem(title: "Save",
                                                              style: .plain,
                                                              target: self,
                                                              action: #selector(EditDraftViewController.saveWasTapped))]
        
        // Text Fields
        titleTextField.placeholder = "Title"
        titleTextField.text = article.title
        
        contentsTextView.layer.cornerRadius = 4.0
        contentsTextView.layer.borderColor = UIColor.black.cgColor
        contentsTextView.layer.borderWidth = 1.0
        contentsTextView.text = article.content
        
        view.addSubview(titleTextField)
        view.addSubview(contentsTextView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let navbarHeight: CGFloat = 44.0
        var topPadding: CGFloat = 20.0
        var bottomPadding: CGFloat = 20.0
        
        if let topInset = UIApplication.shared.keyWindow?.safeAreaInsets.top {
            topPadding += topInset
        }
        if let bottomInset = UIApplication.shared.keyWindow?.safeAreaInsets.bottom {
            bottomPadding += bottomInset
        }
        
        titleTextField.bounds = CGRect(x: 0, y: 0, width: view.bounds.width - 32.0, height: 44.0)
        titleTextField.center = CGPoint(x: titleTextField.bounds.width/2.0 + 16.0, y: titleTextField.bounds.height/2.0 + topPadding + navbarHeight)
        
        let contentsTextViewYOrigin = titleTextField.bounds.height + titleTextField.frame.origin.y + 20.0
        let height = view.bounds.height - navbarHeight - titleTextField.bounds.height - 20 - 20 - bottomPadding
        contentsTextView.frame = CGRect(x: 16.0, y: contentsTextViewYOrigin, width: view.bounds.width - 32.0, height: height)
    }
}
