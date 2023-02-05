import Foundation
import InoreaderSwift

extension ArticleModel {

    init(item : StreamContents.Item) {
        var url : URL? = nil
        if let canonical = item.canonical.first {
            url = URL(string: canonical.href)
        }

        self.init(
            id: item.id,
            title: item.title,
            content: item.summary.content,
            url: url,
            imageUrl: nil,
            publishedAt: Date(timeIntervalSince1970: TimeInterval(item.published))
        )
    }
}
