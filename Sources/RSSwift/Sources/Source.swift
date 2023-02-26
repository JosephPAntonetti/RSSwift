import Foundation

public protocol Source {

  // Get Items
  func getItemIds(
    since: Date?,
    unreadOnly: Bool
  ) async -> [String]

  func getItems(
    since: Date?,
    unreadOnly: Bool
  ) async -> [StreamItem]

  // Get Subscriptions
  func getSubscriptions() async -> [Subscription]

  // Mutating APIs
  func markAsRead(_ items: [String], isRead: Bool) async
  func star(_ items: [String], isStarred: Bool) async

}
