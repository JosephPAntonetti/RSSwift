import Foundation

public protocol RSSProvider {

  // Get Items
  func getArticleIDs(
    since: Date?,
    unreadOnly: Bool
  ) async -> [String]

  func getArticles(
    since: Date?,
    unreadOnly: Bool
  ) async -> [Article]

  // Get Subscriptions
  func getSubscriptions() async -> [Subscription]

  func markAsRead(_ articleIDs: [String], isRead: Bool) async
  func star(_ articleIDs: [String], isStarred: Bool) async

}
