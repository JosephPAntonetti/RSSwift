import Foundation

public class GReaderRSSProvider : RSSProvider {

  private let client: GReaderApiClient

  public init(baseURL: String, headers: [String: String]) {
    client = GReaderApiClient(baseURL: baseURL, headers: headers)
  }

  public func getArticleIDs(since: Date?, unreadOnly: Bool) async -> [String] {
    let excludeTarget = unreadOnly ? GReaderConstants.ReadCategory : nil
    let startTime = since?.timeIntervalSince1970 != nil ? Int(since!.timeIntervalSince1970) : nil

    var response = await client.getStreamItemIds(
      id: GReaderConstants.ReadingListCategory,
      count: 1000,
      startTime: startTime,
      excludeTarget: excludeTarget
    )

    var items = response?.itemRefs ?? []
    var continuation = response?.continuation

    while continuation != nil {

      response = await client.getStreamItemIds(
        id: GReaderConstants.ReadingListCategory,
        count: 1000,
        startTime: startTime,
        excludeTarget: excludeTarget
      )

      if let newItems = response?.itemRefs {
        items.append(contentsOf: newItems)
      }

      continuation = response?.continuation
    }

    return items.map({ $0.id })
  }

  public func getArticles(since: Date?, unreadOnly: Bool) async -> [Article] {
    let excludeTarget = unreadOnly ? GReaderConstants.ReadCategory : nil
    let startTime = since?.timeIntervalSince1970 != nil ? Int(since!.timeIntervalSince1970) : nil

    var response = await client.getItemsForStream(
      id: GReaderConstants.ReadingListCategory,
      count: 1000,
      startTime: startTime,
      excludeTarget: excludeTarget
    )

    var items = response?.items ?? []
    var continuation = response?.continuation

    while continuation != nil {

      response = await client.getItemsForStream(
        id: GReaderConstants.ReadingListCategory,
        count: 1000,
        startTime: startTime,
        excludeTarget: excludeTarget,
        continuation: continuation
      )

      if let newItems = response?.items {
        items.append(contentsOf: newItems)
      }

      continuation = response?.continuation
    }

    return items.map({ $0.toArticle() })
  }

  public func getSubscriptions() async -> [Subscription] {
    let response = await client.getSubscriptions()
    return response?.subscriptions.map({ $0.toSubscription() }) ?? []
  }

  public func markAsRead(_ items: [String], isRead: Bool) async {
    let tagToAdd = isRead ? GReaderConstants.ReadCategory : nil
    let tagToRemove = isRead ? nil : GReaderConstants.ReadCategory
    await client.editTags(tagToAdd: tagToAdd, tagToRemove: tagToRemove, itemIds: items)
  }

  public func star(_ items: [String], isStarred: Bool) async {
    let tagToAdd = isStarred ? GReaderConstants.StarredCategory : nil
    let tagToRemove = isStarred ? nil : GReaderConstants.StarredCategory
    await client.editTags(tagToAdd: tagToAdd, tagToRemove: tagToRemove, itemIds: items)
  }
}
