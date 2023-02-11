import Foundation
import LoremSwiftum

extension ArticleModel {
    static func fake() -> ArticleModel {
        return ArticleModel(
            id: UUID().uuidString,
            title: Lorem.title,
            content: Lorem.paragraphs(3),
            url: nil,
            imageUrl: nil,
            publishedAt: Date()
        )
    }
}
