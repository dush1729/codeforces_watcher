//
//  NewsTableViewAdapter.swift
//  Codeforces Watcher
//
//  Created by Den Matyash on 1/2/20.
//  Copyright © 2020 xorum.io. All rights reserved.
//

import UIKit
import common

class NewsTableViewAdapter: NSObject, UITableViewDelegate, UITableViewDataSource {
    var news: [NewsItem] = []

    var onNewsClick: (
        _ link: String,
        _ shareText: String,
        _ onOpen: @escaping () -> (),
        _ onShare: @escaping () -> ()
    ) -> () = { _, _, _, _ in }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (news.isEmpty) {
            return 1
        }

        return news.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (news.isEmpty) {
            return tableView.dequeueReusableCell(cellType: NoItemsTableViewCell.self).apply {
                $0.bind(imageName: "noItemsImage", explanation: "news_explanation")
            }
        }
        
        switch(news[indexPath.row]) {
        case .pinnedItem(let item):
            return tableView.dequeueReusableCell(cellType: PinnedPostTableViewCell.self).apply {
                $0.bind(item)
            }
        case .postWithCommentItem(let item):
            return tableView.dequeueReusableCell(cellType: PostWithCommentTableViewCell.self).apply {
                $0.bind(item)
            }
        case .postItem(let item):
            return tableView.dequeueReusableCell(cellType: PostTableViewCell.self).apply {
                $0.bind(item)
            }
        default:
            fatalError()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (news.isEmpty) {
            return
        }
        
        switch(news[indexPath.row]) {
        case .pinnedItem(let news):
            let shareText = buildShareText(news.title, news.link)
            let onOpen = { analyticsControler.logPinnedPostOpened() }
            let onShare = { analyticsControler.logShareComment() }
            
            onNewsClick(news.link, shareText, onOpen, onShare)
        case .postWithCommentItem(let news):
            let shareText = buildShareText(news.blogTitle, news.commentLink)
            let onOpen = { analyticsControler.logActionOpened() }
            let onShare = { analyticsControler.logShareComment() }
            
            onNewsClick(news.commentLink, shareText, onOpen, onShare)
        case .postItem(let news):
            let shareText = buildShareText(news.blogTitle, news.link)
            let onOpen = { analyticsControler.logActionOpened() }
            let onShare = { analyticsControler.logShareComment() }
            
            onNewsClick(news.link, shareText, onOpen, onShare)
        default:
            return
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (news.isEmpty) {
            return tableView.frame.height
        } else {
            return UITableView.automaticDimension
        }
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 122
    }
}
