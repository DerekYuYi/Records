//
//  Article.swift
//  IntegrateSiriShortcuts
//
//  Created by DerekYuYi on 2019/1/30.
//  Copyright © 2019 Wenlemon. All rights reserved.
//

import UIKit
import Intents
import CoreSpotlight
import MobileCoreServices

public let kNewArticleActivityType = "com.Summer.IntegrateSiriShortcuts"

public class Article {
    public let title: String
    public let content: String
    public let published: Bool
    
    // Create a shortcut for go to writing acticle
    public static func newArticleShortcut(with thumbnail: UIImage?) -> NSUserActivity {
        let activity = NSUserActivity(activityType: kNewArticleActivityType)
        activity.persistentIdentifier = NSUserActivityPersistentIdentifier(kNewArticleActivityType)
        
        activity.isEligibleForSearch = true
        activity.isEligibleForPrediction = true
        
        let attributes = CSSearchableItemAttributeSet(itemContentType: kUTTypeItem as String)
        
        // Title
        activity.title = "写一遍新文章"
        
        // Subtitle
        attributes.contentDescription = "让你的创造力流动起来"
        
        // Thumbnail
        attributes.thumbnailData = thumbnail?.jpegData(compressionQuality: 1.0)
        
        // Suggested Phrase
        activity.suggestedInvocationPhrase = "写文章"
        
        activity.contentAttributeSet = attributes
        
        return activity
    }
    
    // Create an intent for publishing articles
    public func donatePublishIntent() {
        // Xcode generated the class `PostArticleIntent` when you created the ArticleIntents.intentdefinition file.
        let intent = PostArticleIntent()
        intent.article = INObject(identifier: self.title, display: self.title)
        intent.publishDate = formattedDate()
        
        let interaction = INInteraction(intent: intent, response: nil)
        
        interaction.donate(completion: nil)
    }
    
    // MARK: - Init
    public init(title: String, content: String, published: Bool) {
        self.title = title
        self.content = content
        self.published = published
    }
    
    // MARK: - Helpers
    public func toData() -> Data? {
        let dict: [String: Any] = ["title": title, "content": content, "published": published]
        let data = try? NSKeyedArchiver.archivedData(withRootObject: dict, requiringSecureCoding: false)
        return data
    }
    
    public func formattedDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MM/dd/yyyy"
        let result = formatter.string(from: date)
        
        return result
    }
}
