//
//  PostArticleIntentHandler.swift
//  WritingIntents
//
//  Created by DerekYuYi on 2019/2/15.
//  Copyright © 2019 Wenlemon. All rights reserved.
//

import UIKit
import ArticleKit

class PostArticleIntentHandler: NSObject, PostArticleIntentHandling {
    func confirm(intent: PostArticleIntent, completion: @escaping (PostArticleIntentResponse) -> Void) {
        completion(PostArticleIntentResponse(code: PostArticleIntentResponseCode.ready,
                                             userActivity: nil))
    }
    
    func handle(intent: PostArticleIntent, completion: @escaping (PostArticleIntentResponse) -> Void) {
        guard
            let title = intent.article?.identifier,
            let article = ArticleManager.findArticle(with: title)
            else {
                completion(PostArticleIntentResponse.failure(failureReason: "Your article was not found."))
                return
        }
        guard !article.published else {
            completion(PostArticleIntentResponse.failure(failureReason: "This article has already been published."))
            return
        }
        
        ArticleManager.publish(article)
        completion(PostArticleIntentResponse.success(title: article.title, publishDate: article.formattedDate()))
    }
}


