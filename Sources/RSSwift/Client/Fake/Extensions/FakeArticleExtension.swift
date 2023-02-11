import Foundation

extension Article {

  public static func fake() -> Article {
    return Article(model: ArticleModel.fake())
  }
}
