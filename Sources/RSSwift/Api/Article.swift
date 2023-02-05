import Foundation

class Article {

  private let model: ArticleModel

  public var id: String {
    return model.id
  }

  public var title: String {
    return model.title
  }

  public var content: String {
    return model.content
  }

  public var publishDate: Date? {
    return model.publishedAt
  }

  public var url: URL? {
    return model.url
  }

  init(model: ArticleModel) {
    self.model = model
  }
}
