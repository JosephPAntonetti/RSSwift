import Foundation

public class FakeRssClient: RssClient {
  public init() {}

  func getFolders() async -> [FolderModel] {
    return (0...10).map { _ in FolderModel.fake() }
  }

  func getSubscriptions() async -> [SubscriptionModel] {
    return (0...10).map({ _ in SubscriptionModel.fake() })
  }

  func getArticlesForFeed(feedId _: String) async -> [ArticleModel] {
    return (0...40).map({ _ in ArticleModel.fake() })
  }

  func getSubscriptionsForFolder(folderId _: String) async -> [SubscriptionModel] {
    return (0...10).map({ _ in SubscriptionModel.fake() })
  }
}
