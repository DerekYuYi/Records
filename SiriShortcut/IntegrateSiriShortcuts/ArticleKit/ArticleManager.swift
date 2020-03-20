//
//  ArticleManager.swift
//  IntegrateSiriShortcuts
//
//  Created by DerekYuYi on 2019/1/30.
//  Copyright © 2019 Wenlemon. All rights reserved.
//

import UIKit

public class ArticleManager: NSObject {
    private static var articles: [Article] = []
    private static let groupIdentifier = "group.com.Summer.IntegrateSiriShortcuts" // group id
    
    private static var articlesDir: String {
        let groupURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: groupIdentifier)
        if let groupURL = groupURL {
            return groupURL.path + "/Articles"
        } else {
            if let documentsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                return documentsDir.path + "/Articles"
            }
            return ""
        }
    }
    
    public static func update(article: Article, title: String, content: String) -> Article {
        let newArticle = Article(title: title, content: content, published: false)
        remove(article: article)
        add(article: newArticle)
        return newArticle
    }
    
    public static func findArticle(with title: String) -> Article? {
        loadArticles()
//        return articles.first(where: { article -> Bool in
//            article.title == title
//        })
        return articles.first { $0.title == title }
    }
    
    public static func allArticles() -> [Article] {
        return articles
    }
    
    public static func publish(_ article: Article) {
        let publishedArticle = Article(title: article.title, content: article.content, published: true)
        remove(article: article)
        add(article: publishedArticle)
        writeArticlesToDisk()
    }
    
    public static func writeArticlesToDisk() {
        do {
            if !FileManager.default.fileExists(atPath: articlesDir) {
                try FileManager.default.createDirectory(atPath: articlesDir, withIntermediateDirectories: false, attributes: nil)
            }
            
            // Delete all old articles
            let articlePaths = try FileManager.default.contentsOfDirectory(atPath: articlesDir)
            for articlePath in articlePaths  {
                let fullPath = articlesDir + "/\(articlePath)"
                try FileManager.default.removeItem(atPath: fullPath)
                print("Deleted \(articlePath)")
            }
        } catch let e {
            print(e)
        }
        
        for (i, article) in articles.enumerated() {
            let path = articlesDir + "/\(i + 1).article"
            let url = URL(fileURLWithPath: path)
            if let data = article.toData() {
                try? data.write(to: url)
                print("Wrote article \(article.title) published? \(article.published) to \(articlesDir)")
            }
        }
    }
    
    
    public static func add(article: Article) {
        articles.append(article)
    }
    
    public static func remove(article articleToDelete: Article) {
        articles.removeAll { article -> Bool in
            article.title == articleToDelete.title && article.content == articleToDelete.content
        }
    }
    
    public static func loadArticles() {
        var savedArticles: [Article] = []
        
        do {
            if !FileManager.default.fileExists(atPath: articlesDir) {
                try FileManager.default.createDirectory(atPath: articlesDir, withIntermediateDirectories: false, attributes: nil)
            }
            
            let articlePaths = try FileManager.default.contentsOfDirectory(atPath: articlesDir)
            for articlePath in articlePaths {
                let fullPath = articlesDir + "/\(articlePath)"
                if let articleData = FileManager.default.contents(atPath: fullPath), let articleDict = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(articleData) as? [String: Any],
                    let title = articleDict["title"] as? String,
                    let content = articleDict["content"] as? String,
                    let published = articleDict["published"] as? Bool {
                    let article = Article(title: title, content: content, published: published)
                    savedArticles.append(article)
                }
            }
            
        } catch let error {
            debugPrint(error)
        }
        
    }

}
